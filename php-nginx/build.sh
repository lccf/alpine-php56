#!/bin/sh
# nginx https://nginx.org/download/nginx-1.15.12.tar.gz
# nginx-http-concat https://github.com/alibaba/nginx-http-concat/archive/master.zip

download_package() {
  mkdir -p ./src
  for package in $*
  do 
    case "$package" in
      "nginx")
        if [ ! -f "./src/nginx.tar.gz" ]; then
          echo download $package
          curl -Lo ./src/nginx.tar.gz https://nginx.org/download/nginx-1.15.12.tar.gz
        else
          check=$(sha256sum "./src/nginx.tar.gz")
          # 检验sha256
          if [[ $check == 3d5b90aa17de1700709ae4ec6c4d73d87c888b06c510391bf7104b006fdb2abe* ]]; then
            echo $package checked
          else
            echo $package redownload
            rm -fr ./src/nginx.tar.gz
            curl -Lo ./src/nginx.tar.gz https://nginx.org/download/nginx-1.15.12.tar.gz
          fi
        fi
        ;;
      "nginx-http-concat")
        if [ ! -f "./src/nginx-http-concat.zip" ]; then
          echo download $package
          curl -Lo ./src/nginx-http-concat.zip https://github.com/alibaba/nginx-http-concat/archive/master.zip
        else
          check=$(sha256sum "./src/nginx-http-concat.zip")
          # 检验sha256
          if [[ $check == f65e46f7d01d39e60d33c27a53f524cf397084b708c58532cd91f091f1908b4c* ]]; then
            echo $package checked
          else
            echo $package redownload
            rm -fr ./src/nginx-http-concat.zip
            curl -Lo ./src/nginx-http-concat.zip https://github.com/alibaba/nginx-http-concat/archive/master.zip
          fi
        fi
        ;;
    esac
  done
}

main() {
  download_package nginx nginx-http-concat
  docker build -t dev/php-nginx:1.15 .
}

main