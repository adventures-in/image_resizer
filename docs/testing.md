# Testing

## Locally in a container

```shell
$ cd examples/hello
$ docker build -t app .
...

$ docker run -it -p 8080:8080 --name demo --rm app
Listening on :8080
```

In another terminal...

```shell
$ curl localhost:8080
Hello, World!
```
