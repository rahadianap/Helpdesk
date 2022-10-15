<?php


namespace MoTranslator;

class Loader
{
    /**
     * Loader instance.
     *
     * @static
     *
     * @var Loader
     */
    private static $_instance;

    /**
     * Default gettext domain to use.
     *
     * @var string
     */
    private $default_domain = '';

    /**
     * Configured locale.
     *
     * @var string
     */
    private $locale = '';

    /**
     * Loaded domains.
     *
     * @var array
     */
    private $domains = array();

    /**
     * Bound paths for domains.
     *
     * @var array
     */
    private $paths = array('' => './');

    /**
     * Returns the singleton Loader object.
     *
     * @return Loader object
     */
    public static function getInstance()
    {
        if (empty(self::$_instance)) {
            self::$_instance = new self();
        }

        return self::$_instance;
    }

    /**
     * Loads global localizaton functions.
     */
    public static function loadFunctions()
    {
        require_once __DIR__ . '/functions.php';
    }

    /**
     * Figure out all possible locale names and start with the most
     * specific ones.  I.e. for sr_CS.UTF-8@latin, look through all of
     * sr_CS.UTF-8@latin, sr_CS@latin, sr@latin, sr_CS.UTF-8, sr_CS, sr.
     *
     * @param string $locale Locale code
     *
     * @return array list of locales to try for any POSIX-style locale specification
     */
    public static function listLocales($locale)
    {
        $locale_names = array();

        $lang = null;
        $country = null;
        $charset = null;
        $modifier = null;

        if ($locale) {
            if (preg_match('/^(?P<lang>[a-z]{2,3})'                      . '(?:_(?P<country>[A-Z]{2}))?'                           . '(?:\\.(?P<charset>[-A-Za-z0-9_]+))?'                   . '(?:@(?P<modifier>[-A-Za-z0-9_]+))?$/',                 $locale, $matches)) {
                extract($matches);

                if ($modifier) {
                    if ($country) {
                        if ($charset) {
                            array_push($locale_names, "${lang}_$country.$charset@$modifier");
                        }
                        array_push($locale_names, "${lang}_$country@$modifier");
                    } elseif ($charset) {
                        array_push($locale_names, "${lang}.$charset@$modifier");
                    }
                    array_push($locale_names, "$lang@$modifier");
                }
                if ($country) {
                    if ($charset) {
                        array_push($locale_names, "${lang}_$country.$charset");
                    }
                    array_push($locale_names, "${lang}_$country");
                } elseif ($charset) {
                    array_push($locale_names, "${lang}.$charset");
                }
                array_push($locale_names, $lang);
            }

                        if (!in_array($locale, $locale_names)) {
                array_push($locale_names, $locale);
            }
        }

        return $locale_names;
    }

    /**
     * Returns Translator object for domain or for default domain.
     *
     * @param string $domain Translation domain
     *
     * @return Translator
     */
    public function getTranslator($domain = '')
    {
        if (empty($domain)) {
            $domain = $this->default_domain;
        }

        if (!isset($this->domains[$domain])) {
            if (isset($this->paths[$domain])) {
                $base = $this->paths[$domain];
            } else {
                $base = './';
            }

            $locale_names = $this->listLocales($this->locale);

            $filename = '';
            foreach ($locale_names as $locale) {
                $filename = "$base/$locale/LC_MESSAGES/$domain.mo";
                if (file_exists($filename)) {
                    break;
                }
            }

                                    $this->domains[$domain] = new Translator($filename);
        }

        return $this->domains[$domain];
    }

    /**
     * Sets the path for a domain.
     *
     * @param string $domain Domain name
     * @param string $path   Path where to find locales
     */
    public function bindtextdomain($domain, $path)
    {
        $this->paths[$domain] = $path;
    }

    /**
     * Sets the default domain.
     *
     * @param string $domain Domain name
     */
    public function textdomain($domain)
    {
        $this->default_domain = $domain;
    }

    /**
     * Sets a requested locale.
     *
     * @param string $locale Locale name
     *
     * @return string Set or current locale
     */
    public function setlocale($locale)
    {
        if (!empty($locale)) {
            $this->locale = $locale;
                        if (function_exists('setlocale')) {
                setlocale(0, $locale);
            }
        }

        return $this->locale;
    }

    /**
     * Detects currently configured locale.
     *
     * It checks:
     *
     * - global lang variable
     * - environment for LC_ALL, LC_MESSAGES and LANG
     *
     * @return string with locale name
     */
    public function detectlocale()
    {
        if (isset($GLOBALS['lang'])) {
            return $GLOBALS['lang'];
        } elseif (getenv('LC_ALL')) {
            return getenv('LC_ALL');
        } elseif (getenv('LC_MESSAGES')) {
            return getenv('LC_MESSAGES');
        } elseif (getenv('LANG')) {
            return getenv('LANG');
        }

        return 'en';
    }
}
