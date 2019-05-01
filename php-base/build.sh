#!/bin/sh
# php url https://www.php.net/distributions/php-5.6.40.tar.xz

download_package() {
  mkdir -p ./src
  for package in $*
  do 
    case "$package" in
      "php")
        if [ ! -f "./src/php.tar.xz" ]; then
          echo download $package
          curl -Lo ./src/php.tar.xz https://www.php.net/distributions/php-5.6.40.tar.xz
        else
          check=$(sha256sum "./src/php.tar.xz")
          # 检验sha256
          if [[ $check == 1369a51eee3995d7fbd1c5342e5cc917760e276d561595b6052b21ace2656d1c* ]]; then
            echo $package checked
          else
            echo $package redownload
            rm -fr ./src/php.tar.xz
            curl -Lo ./src/php.tar.xz https://www.php.net/distributions/php-5.6.40.tar.xz
          fi
        fi
        ;;
    esac
  done
}

main() {
  download_package php
  docker build -t dev/php-base:5.6 .
}

main