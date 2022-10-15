<?php



namespace Symfony\Component\Cache\Simple;

use Doctrine\Common\Cache\CacheProvider;
use Symfony\Component\Cache\Traits\DoctrineTrait;

class DoctrineCache extends AbstractCache
{
    use DoctrineTrait;

    /**
     * @param CacheProvider $provider
     * @param string        $namespace
     * @param int           $defaultLifetime
     */
    public function __construct(CacheProvider $provider, $namespace = '', $defaultLifetime = 0)
    {
        parent::__construct('', $defaultLifetime);
        $this->provider = $provider;
        $provider->setNamespace($namespace);
    }
}
