# Valheim Docker

Unofficial Valheim containerized, dedicated gameserver.  
https://www.valheimgame.com/

## Run Container

```
docker run -itd \
    --name=valheim \
    -e SERVER_NAME="ValheimServer" \
    -e SERVER_WORLD="Valhalla" \
    -e SERVER_PASSWORD="secret" \
    -e SERVER_PUBLIC="0.0.0.0" \
    -e SERVER_PORT="2456" \
    -e UPDATE_ON_RESTART="1" \
    -v $(pwd)/data:/data \
    -p 2456:2456/udp \
    -p 2457:2457/udp \
    -p 2458:2458/udp \
    quay.io/cbrgm/valheim-docker:latest
```

or build your own container image:

```
docker build -t valheim-docker:latest .
```

### Kubernetes Deployment

You may also deploy the server on a kubernetes cluster. For some inspiration please have a look at `deploy.yaml` and adapt it to your needs.

## Environment Variables

* `SERVER_NAME`: The server name to be displayed in the multiplayer browser menu. (Example: ValheimServer)
* `SERVER_WORLD`:"The server's world name. (Example: Valhalla)
* `SERVER_PASSWORD`: The server's password. (Example: secret)
* `SERVER_PUBLIC`: The server's public ip address. Example: (0.0.0.0)
* `SERVER_PORT`: The server port to bind on. (Example: 2456)
* `UPDATE_ON_RESTART`"If set to 1, check for available updates on each restart and install when found. (Default: 1)

## Persist server data

All data is persisted at the `/data` directory inside the container. A host mount can be created via the `-v $(pwd)/data:/data` flag as shown above.

To add your own worlds, create a folder `worlds` at `$(pwd)/data/worlds`, add your world files and change the `SERVER_WORLD` environment variable matching your world's name.

## Contributing & License

Feel free to submit changes! See the [Contributing Guide](https://github.com/cbrgm/contributing/blob/master/CONTRIBUTING.md). This project is open-source and is developed under the terms of the [Apache 2.0 License](https://github.com/cbrgm/valheim-docker/blob/master/LICENSE).
