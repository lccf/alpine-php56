### 编译说明

软件版本

- alpine 3.8
- php 5.6.40
- nginx 1.15.12

编译中有很多试错的过程，为节省时间，分成了几个版本，出错后不用从头开始编译。

- alpine 设置时区，做基础alpine镜像
- php-base 编译后的php，没有添加扩展
- php-ext 添加了pdo_mysql、bcmath、intl、gd、opcache、redis、xdebug、memcached待扩展
- php-nginx 编译nginx，添中nginx扩展，设置启动脚本 

按照先后顺序，执行build.sh脚本进行编译。

php编译脚本是从docker-library/php项目修改来的，最新版本已经移除5.6了，需要切换到fab49d4的commit。默认是在dockerfile下载php安装包的，国外网络环境速度比较慢，改为build脚本下载，也可以手动下载好，编译的时候节省时间。

php插件安装的脚本是docker-library/php自带的，使用起来比较方便。但是安装php扩展装的依赖库体积增加了50MB，目前还没有好的解决办法。

nginx脚本是从nginxinc/docker-nginx项目修改来，添加了nginx-http-concat插件。nginx-http-concat项目上release版本有问题，需要下载master分支的源码。

### 使用说明

默认项目目录 /var/www 启用时默认开启nginx和php。

示例：
```bash
docker run --rm -d --name php5 \
    -p 80:80 \
    -v /workdir/conf:/etc/nginx/conf.d \
    -v /workdir/www:/var/www \
    dev/php-nginx:1.15
```


### 链接

- docker-library/docker-php [https://github.com/docker-library/php/commit/fab49d4cb1c61e4f74c2dffe06961408212f054c](https://github.com/docker-library/php/commit/fab49d4cb1c61e4f74c2dffe06961408212f054c)
- nginxinc/docker-nginx [https://github.com/nginxinc/docker-nginx](https://github.com/nginxinc/docker-nginx)