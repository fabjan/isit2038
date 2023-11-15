# isit2038

`isit2038` is a service that lets you know if 03:14:07 UTC on 19 January 2038 has passed.

## Requirements

* [Poly/ML] or [MLton]

[Poly/ML]: https://www.polyml.org
[MLton]: http://mlton.org

## Building

A local build:
```
./build.sh
```

Build a container image:
```
podman build . -t isit2038
```

## Running

A local build:
```
_build/isit2038
```

A container:
```
podman run --rm -it -p3000:3000 isit2038
```

Connect a client:
```
curl http://localhost:3000
```
