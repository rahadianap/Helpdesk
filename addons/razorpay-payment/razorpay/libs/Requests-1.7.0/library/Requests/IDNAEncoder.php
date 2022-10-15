<?php

/**
 * IDNA URL encoder
 *
 * Note: Not fully compliant, as nameprep does nothing yet.
 *
 * @package Requests
 * @subpackage Utilities
 * @see https://tools.ietf.org/html/rfc3490 IDNA specification
 * @see https://tools.ietf.org/html/rfc3492 Punycode/Bootstrap specification
 */
class Requests_IDNAEncoder {
	/**
	 * ACE prefix used for IDNA
	 *
	 * @see https://tools.ietf.org/html/rfc3490#section-5
	 * @var string
	 */
	const ACE_PREFIX = 'xn--';

	
	const BOOTSTRAP_BASE         = 36;
	const BOOTSTRAP_TMIN         = 1;
	const BOOTSTRAP_TMAX         = 26;
	const BOOTSTRAP_SKEW         = 38;
	const BOOTSTRAP_DAMP         = 700;
	const BOOTSTRAP_INITIAL_BIAS = 72;
	const BOOTSTRAP_INITIAL_N    = 128;
	

	/**
	 * Encode a hostname using Punycode
	 *
	 * @param string $string Hostname
	 * @return string Punycode-encoded hostname
	 */
	public static function encode($string) {
		$parts = explode('.', $string);
		foreach ($parts as &$part) {
			$part = self::to_ascii($part);
		}
		return implode('.', $parts);
	}

	/**
	 * Convert a UTF-8 string to an ASCII string using Punycode
	 *
	 * @throws Requests_Exception Provided string longer than 64 ASCII characters (`idna.provided_too_long`)
	 * @throws Requests_Exception Prepared string longer than 64 ASCII characters (`idna.prepared_too_long`)
	 * @throws Requests_Exception Provided string already begins with xn-- (`idna.provided_is_prefixed`)
	 * @throws Requests_Exception Encoded string longer than 64 ASCII characters (`idna.encoded_too_long`)
	 *
	 * @param string $string ASCII or UTF-8 string (max length 64 characters)
	 * @return string ASCII string
	 */
	public static function to_ascii($string) {
				if (self::is_ascii($string)) {
						if (strlen($string) < 64) {
				return $string;
			}

			throw new Requests_Exception('Provided string is too long', 'idna.provided_too_long', $string);
		}

				$string = self::nameprep($string);

						if (self::is_ascii($string)) {
						if (strlen($string) < 64) {
				return $string;
			}

			throw new Requests_Exception('Prepared string is too long', 'idna.prepared_too_long', $string);
		}

				if (strpos($string, self::ACE_PREFIX) === 0) {
			throw new Requests_Exception('Provided string begins with ACE prefix', 'idna.provided_is_prefixed', $string);
		}

				$string = self::punycode_encode($string);

				$string = self::ACE_PREFIX . $string;

				if (strlen($string) < 64) {
			return $string;
		}

		throw new Requests_Exception('Encoded string is too long', 'idna.encoded_too_long', $string);
	}

	/**
	 * Check whether a given string contains only ASCII characters
	 *
	 * @internal (Testing found regex was the fastest implementation)
	 *
	 * @param string $string
	 * @return bool Is the string ASCII-only?
	 */
	protected static function is_ascii($string) {
		return (preg_match('/(?:[^\x00-\x7F])/', $string) !== 1);
	}

	/**
	 * Prepare a string for use as an IDNA name
	 *
	 * @todo Implement this based on RFC 3491 and the newer 5891
	 * @param string $string
	 * @return string Prepared string
	 */
	protected static function nameprep($string) {
		return $string;
	}

	/**
	 * Convert a UTF-8 string to a UCS-4 codepoint array
	 *
	 * Based on Requests_IRI::replace_invalid_with_pct_encoding()
	 *
	 * @throws Requests_Exception Invalid UTF-8 codepoint (`idna.invalidcodepoint`)
	 * @param string $input
	 * @return array Unicode code points
	 */
	protected static function utf8_to_codepoints($input) {
		$codepoints = array();

				$strlen = strlen($input);

		for ($position = 0; $position < $strlen; $position++) {
			$value = ord($input[$position]);

						if ((~$value & 0x80) === 0x80) {
				$character = $value;
				$length = 1;
				$remaining = 0;
			}
						elseif (($value & 0xE0) === 0xC0) {
				$character = ($value & 0x1F) << 6;
				$length = 2;
				$remaining = 1;
			}
						elseif (($value & 0xF0) === 0xE0) {
				$character = ($value & 0x0F) << 12;
				$length = 3;
				$remaining = 2;
			}
						elseif (($value & 0xF8) === 0xF0) {
				$character = ($value & 0x07) << 18;
				$length = 4;
				$remaining = 3;
			}
						else {
				throw new Requests_Exception('Invalid Unicode codepoint', 'idna.invalidcodepoint', $value);
			}

			if ($remaining > 0) {
				if ($position + $length > $strlen) {
					throw new Requests_Exception('Invalid Unicode codepoint', 'idna.invalidcodepoint', $character);
				}
				for ($position++; $remaining > 0; $position++) {
					$value = ord($input[$position]);

										if (($value & 0xC0) !== 0x80) {
						throw new Requests_Exception('Invalid Unicode codepoint', 'idna.invalidcodepoint', $character);
					}

					$character |= ($value & 0x3F) << (--$remaining * 6);
				}
				$position--;
			}

			if (
								   $length > 1 && $character <= 0x7F
				|| $length > 2 && $character <= 0x7FF
				|| $length > 3 && $character <= 0xFFFF
												|| ($character & 0xFFFE) === 0xFFFE
				|| $character >= 0xFDD0 && $character <= 0xFDEF
				|| (
										   $character > 0xD7FF && $character < 0xF900
					|| $character < 0x20
					|| $character > 0x7E && $character < 0xA0
					|| $character > 0xEFFFD
				)
			) {
				throw new Requests_Exception('Invalid Unicode codepoint', 'idna.invalidcodepoint', $character);
			}

			$codepoints[] = $character;
		}

		return $codepoints;
	}

	/**
	 * RFC3492-compliant encoder
	 *
	 * @internal Pseudo-code from Section 6.3 is commented with "#" next to relevant code
	 * @throws Requests_Exception On character outside of the domain (never happens with Punycode) (`idna.character_outside_domain`)
	 *
	 * @param string $input UTF-8 encoded string to encode
	 * @return string Punycode-encoded string
	 */
	public static function punycode_encode($input) {
		$output = '';
		$n = self::BOOTSTRAP_INITIAL_N;
		$delta = 0;
		$bias = self::BOOTSTRAP_INITIAL_BIAS;
		$h = $b = 0; 		$codepoints = self::utf8_to_codepoints($input);
		$extended = array();

		foreach ($codepoints as $char) {
			if ($char < 128) {
												$output .= chr($char);
				$h++;
			}
												elseif ($char < $n) {
				throw new Requests_Exception('Invalid character', 'idna.character_outside_domain', $char);
			}
						else {
				$extended[$char] = true;
			}
		}
		$extended = array_keys($extended);
		sort($extended);
		$b = $h;
		if (strlen($output) > 0) {
			$output .= '-';
		}
		while ($h < count($codepoints)) {
			$m = array_shift($extended);
						$delta += ($m - $n) * ($h + 1);
			$n = $m;
			for ($num = 0; $num < count($codepoints); $num++) {
				$c = $codepoints[$num];
				if ($c < $n) {
					$delta++;
				}
				elseif ($c === $n) {
					$q = $delta;
					for ($k = self::BOOTSTRAP_BASE; ; $k += self::BOOTSTRAP_BASE) {
						if ($k <= ($bias + self::BOOTSTRAP_TMIN)) {
							$t = self::BOOTSTRAP_TMIN;
						}
						elseif ($k >= ($bias + self::BOOTSTRAP_TMAX)) {
							$t = self::BOOTSTRAP_TMAX;
						}
						else {
							$t = $k - $bias;
						}
						if ($q < $t) {
							break;
						}
						$digit = $t + (($q - $t) % (self::BOOTSTRAP_BASE - $t));
						$output .= self::digit_to_char($digit);
						$q = floor(($q - $t) / (self::BOOTSTRAP_BASE - $t));
					}
					$output .= self::digit_to_char($q);
					$bias = self::adapt($delta, $h + 1, $h === $b);
					$delta = 0;
					$h++;
				}
			}
			$delta++;
			$n++;
		}

		return $output;
	}

	/**
	 * Convert a digit to its respective character
	 *
	 * @see https://tools.ietf.org/html/rfc3492#section-5
	 * @throws Requests_Exception On invalid digit (`idna.invalid_digit`)
	 *
	 * @param int $digit Digit in the range 0-35
	 * @return string Single character corresponding to digit
	 */
	protected static function digit_to_char($digit) {
						if ($digit < 0 || $digit > 35) {
			throw new Requests_Exception(sprintf('Invalid digit %d', $digit), 'idna.invalid_digit', $digit);
		}
				$digits = 'abcdefghijklmnopqrstuvwxyz0123456789';
		return substr($digits, $digit, 1);
	}

	/**
	 * Adapt the bias
	 *
	 * @see https://tools.ietf.org/html/rfc3492#section-6.1
	 * @param int $delta
	 * @param int $numpoints
	 * @param bool $firsttime
	 * @return int New bias
	 */
	protected static function adapt($delta, $numpoints, $firsttime) {
		if ($firsttime) {
			$delta = floor($delta / self::BOOTSTRAP_DAMP);
		}
		else {
			$delta = floor($delta / 2);
		}
		$delta += floor($delta / $numpoints);
		$k = 0;
		$max = floor(((self::BOOTSTRAP_BASE - self::BOOTSTRAP_TMIN) * self::BOOTSTRAP_TMAX) / 2);
		while ($delta > $max) {
			$delta = floor($delta / (self::BOOTSTRAP_BASE - self::BOOTSTRAP_TMIN));
			$k += self::BOOTSTRAP_BASE;
		}
		return $k + floor(((self::BOOTSTRAP_BASE - self::BOOTSTRAP_TMIN + 1) * $delta) / ($delta + self::BOOTSTRAP_SKEW));
	}
}