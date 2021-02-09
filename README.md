# Valheim Docker

Unofficial Valheim containerized, dedicated gameserver.  
https://www.valheimgame.com/

[![Build Status](https://drone.cbrgm.net/api/badges/cbrgm/valheim-docker/status.svg)](https://drone.cbrgm.net/cbrgm/valheim-docker)
[![Docker Repository on Quay](https://quay.io/repository/cbrgm/valheim-docker/status "Docker Repository on Quay")](https://quay.io/repository/cbrgm/valheim-docker)

## Run Container

```
docker run -itd \
    --name=valheim \
    -e SERVER_NAME="ValheimServer" \
    -e SERVER_WORLD="Valhalla" \
    -e SERVER_PASSWORD="secret" \
    -e SERVER_PORT="2456" \
    -e UPDATE_ON_RESTART="1" \
    -v $(pwd)/data:/data \
    -p 2456:2456/udp \
    -p 2457:2457/udp \
    -p 2458:2458/udp \
    quay.io/cbrgm/valheim-docker:latest
```

or use the oneliner version, without persistence and default values as described in the environment variables section

```
docker run -itd -p 2456-2458:2456-2458/udp quay.io/cbrgm/valheim-docker:latest
```

or build your own container image:

```
docker build -t valheim-docker:latest .
```

## Environment Variables

* `SERVER_NAME`: The server name to be displayed in the multiplayer browser menu. (Example: ValheimServer)
* `SERVER_WORLD`:"The server's world name. (Example: Valhalla)
* `SERVER_PASSWORD`: The server's password. (Example: secret)
* `SERVER_PORT`: The server port to bind on. (Example: 2456)
* `UPDATE_ON_RESTART`"If set to 1, check for available updates on each restart and install when found. (Default: 1)

## Connecting

Open Steam's Server View  via `Steam -> View -> Servers`.

Find your server using `<network_addr>:<port>`, where `network_addr` is your servers (public) ip address and port is the port number provided via `SERVER_PORT` environment variable + 1. Example: `-e SERVER_PORT=2456`, connection port is `2457`.

Add your server to favorites. You can join directly via Steam or use the Valheim Lobby Browser ingame.
In case the server is not showing up neither on Steam's server view nor in the lobby browser, make sure your firewall and NAT settings are configured correctly. The same procedure applies for LAN games, just start the container on a host machine and connect via your local ip address and port number as described above.

## Persist server data

All data is persisted at the `/data` directory inside the container. A host mount can be created via the `-v $(pwd)/data:/data` flag as shown above. The uid of the container `valheim` user is `1000`. When mapping files from your host into the container, make sure the host users uid matches the container user.

To add your own worlds, create a folder `worlds` at `$(pwd)/data/worlds`, add your world files and change the `SERVER_WORLD` environment variable matching your world's name.

## Kubernetes Deployment

You may also deploy the server on a kubernetes cluster. For some inspiration please have a look at `deploy.yml` and adapt it to your needs.

## Contributing & License

Feel free to submit changes! See the [Contributing Guide](https://github.com/cbrgm/contributing/blob/master/CONTRIBUTING.md). This project is open-source and is developed under the terms of the [Apache 2.0 License](https://github.com/cbrgm/valheim-docker/blob/master/LICENSE).
