#!/bin/sh
# php memcached https://github.com/php-memcached-dev/php-memcached/archive/2.2.0.tar.gz
# php redis https://github.com/phpredis/phpredis/archive/4.3.0.tar.gz
# xdebug https://xdebug.org/files/xdebug-2.5.5.tgz

download_package() {
  mkdir -p ./src
  for package in $*
  do 
    case "$package" in
      "memcached")
        if [ ! -f "./src/memcached.tar.gz" ]; then
          echo download $package
          curl -Lo ./src/memcached.tar.gz https://github.com/php-memcached-dev/php-memcached/archive/2.2.0.tar.gz
        else
          check=$(sha256sum "./src/memcached.tar.gz")
          # 检验sha256
          if [[ $check == 7248ac9eefedd8ed6babb68da66d58c2a769e9d12380ab9409246cdd7478c00d* ]]; then
            echo $package checked
          else
            echo $package redownload
            rm -fr ./src/memcached.tar.gz
            curl -Lo ./src/memcached.tar.gz https://github.com/php-memcached-dev/php-memcached/archive/2.2.0.tar.gz
          fi
        fi
        ;;
      "redis")
        if [ ! -f "./src/redis.tar.gz" ]; then
          echo download $package
          curl -Lo ./src/redis.tar.gz https://github.com/phpredis/phpredis/archive/4.3.0.tar.gz
        else
          check=$(sha256sum "./src/redis.tar.gz")
          # 检验sha256
          if [[ $check == c854a39a691e7fbb813f948145a8d9042a9455295c50cc6766766c5f0693c92d* ]]; then
            echo $package checked
          else
            echo $package redownload
            rm -fr ./src/redis.tar.gz
            curl -Lo ./src/redis.tar.gz https://github.com/phpredis/phpredis/archive/4.3.0.tar.gz
          fi
        fi
        ;;
      "xdebug")
        if [ ! -f "./src/xdebug.tgz" ]; then
          echo download $package
          curl -Lo ./src/xdebug.tgz https://xdebug.org/files/xdebug-2.5.5.tgz
        else
          check=$(sha256sum "./src/xdebug.tgz")
          # 检验sha256
          if [[ $check == 72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4* ]]; then
            echo $package checked
          else
            echo $package redownload
            rm -fr ./src/xdebug.tgz
            curl -Lo ./src/xdebug.tgz https://xdebug.org/files/xdebug-2.5.5.tgz
          fi
        fi
        ;;
    esac
  done
}

main() {
  download_package redis memcached xdebug
  docker build -t dev/php-ext:5.6 .
}

main