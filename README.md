# phpco

An installation of PHP7 and [PHP Compatibility](https://github.com/PHPCompatibility/PHPCompatibility) in a small Alpine Linux Docker image.

## PHPCompatibility

PHPCompatibility is built as a _code standard_ for the `phpcs` command. It searches your code for patterns matching a long list of deprecated functions and use cases. It gives very direct instructions about what might be deprecated, wrong or risky with your code on any specified PHP version.

## Motivations

Using PHPCompatibility requires you to first install PHP CodeSniffer globally and then configure PHPCompatibility as the code standard to use. We find that the easiest way to run it is with Docker, since that cleanly separates your local PHP setup from the tool.

## Getting phpco-docker

The easiest way is to create a shell function for `phpco`. No need to clone this repository. First make sure you have [Docker](https://docs.docker.com/install) installed on your machine. Then execute this in your local terminal:

```sh
phpco() { docker run --init -v $PWD:/mnt/src:cached --rm -u "$(id -u):$(id -g)" frbit/phpco:latest $@; return $?; }
```

You can also add this snippet to your `.bashrc` or similar shell startup script. That way it will always be available whenever you open a new shell.

## Running phpco-docker
Now you can directly use the tool. This command will do a full check of all your code in the current directory for PHP 8.0 compatibility.
```
phpco -p --colors --extensions=php --runtime-set testVersion 8.0 .
```

As it completes you will see a list of found warnings and errors in your code. If you are getting a lot of warnings, but only want to deal with the stuff that will actually break, add `-n` to only show errors.

If you have also updated all of your dependencies and are sure they support the PHP version you want to migrate to, you can exclude the `vendor` folder completely to only check your own code. Checking for PHP version 8.0 is the default so we can also remove that part.

```
phpco -p --colors --extensions=php . -n --ignore="vendor/"
```

Remember: Since this is running within a docker container, the paths to your source files will start with `/mnt/src/` instead of the actual absolute path on your host computer.

[Read more about available flags specific to PHP Compatibility](https://github.com/PHPCompatibility/PHPCompatibility) and about the [underlying options for PHP CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer/wiki/Usage).
