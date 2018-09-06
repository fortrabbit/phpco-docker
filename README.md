# phpco

An installation of PHP7 and [PHP Compatibility](https://github.com/PHPCompatibility/PHPCompatibility) in a small Alpine Linux Docker image.

## Motivations

By packaging PHP CodeSniffer with PHP Compatibility preinstalled inside a Docker image, we can separate the runtime and configuration of the tool from your application’s environment and requirements.

## Getting phpco-docker

The easiest way is to create a shell function for `phpco`. This makes makes it nearly transparent that it is running inside Docker.

```sh
phan() { docker run --init -v $PWD:/mnt/src --rm -u "$(id -u):$(id -g)" frbit/phpco:latest $@; return $?; }
```

(You may replace “latest” with a tagged PHP Compatibility release to use a specific version.)

## Running phpco-docker
We have added some reasonable defaults to the container, so you can just run the command directly. This will do a full check of all your code for PHP 7.2 compatibility.
```
phpco
```

You can also customise your run and use all command line flags available for `phpcs`, for example:
```
phpco -p --colors --runtime-set testVersion 7.2 .
```

Read more about available flags specific to [PHP Compatibility](https://github.com/PHPCompatibility/PHPCompatibility) and about the underlying options for [PHP CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer/wiki).
