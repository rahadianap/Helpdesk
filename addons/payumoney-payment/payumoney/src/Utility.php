<?php

namespace Razorpay\Api;

class Utility
{
    const SHA256 = 'sha256';

    public function verifyPaymentSignature($attributes)
    {
        $actualSignature = $attributes['razorpay_signature'];

        $paymentId = $attributes['razorpay_payment_id'];

        if (isset($attributes['razorpay_order_id']) === true)
        {
            $orderId = $attributes['razorpay_order_id'];

            $payload = $orderId . '|' . $paymentId;
        }
        else if (isset($attributes['razorpay_subscription_id']) === true)
        {
            $subscriptionId = $attributes['razorpay_subscription_id'];

            $payload = $paymentId . '|' . $subscriptionId;
        }
        else
        {
            throw new Errors\SignatureVerificationError(
                'Either razorpay_order_id or razorpay_subscription_id must be present.');
        }

        $secret = Api::getSecret();

        self::verifySignature($payload, $actualSignature, $secret);
    }

    public function verifyWebhookSignature($payload, $actualSignature, $secret)
    {
        self::verifySignature($payload, $actualSignature, $secret);
    }

    public function verifySignature($payload, $actualSignature, $secret)
    {
        $expectedSignature = hash_hmac(self::SHA256, $payload, $secret);

                if (function_exists('hash_equals'))
        {
            $verified = hash_equals($expectedSignature, $actualSignature);
        }
        else
        {
            $verified = $this->hashEquals($expectedSignature, $actualSignature);
        }

        if ($verified === false)
        {
            throw new Errors\SignatureVerificationError(
                'Invalid signature passed');
        }
    }

    private function hashEquals($expectedSignature, $actualSignature)
    {
        if (strlen($expectedSignature) === strlen($actualSignature))
        {
            $res = $expectedSignature ^ $actualSignature;
            $return = 0;

            for ($i = strlen($res) - 1; $i >= 0; $i--)
            {
                $return |= ord($res[$i]);
            }

            return ($return === 0);
        }

        return false;
    }
}
