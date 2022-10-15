<?php



namespace Symfony\Component\Cache\Simple;

use Symfony\Component\Cache\Exception\CacheException;
use Symfony\Component\Cache\Traits\PhpFilesTrait;

class PhpFilesCache extends AbstractCache
{
    use PhpFilesTrait;

    /**
     * @param string      $namespace
     * @param int         $defaultLifetime
     * @param string|null $directory
     *
     * @throws CacheException if OPcache is not enabled
     */
    public function __construct($namespace = '', $defaultLifetime = 0, $directory = null)
    {
        if (!static::isSupported()) {
            throw new CacheException('OPcache is not enabled');
        }
        parent::__construct('', $defaultLifetime);
        $this->init($namespace, $directory);

        $e = new \Exception();
        $this->includeHandler = function () use ($e) { throw $e; };
        $this->zendDetectUnicode = ini_get('zend.detect_unicode');
    }
}
