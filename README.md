![Docker Pulls](https://img.shields.io/docker/pulls/wafy80/tor)
![Docker Image Size](https://img.shields.io/docker/image-size/wafy80/tor)
![Docker Build](https://github.com/wafy80/tor/actions/workflows/image-build.yml/badge.svg)
# Tor Proxy Docker Image

## Overview
This Docker image provides a simple and easy-to-use Tor proxy service. Tor is a free and open-source software that anonymizes internet traffic by routing it through a worldwide network of relays.

## Features
- **Tor Proxy**: Configured as a SOCKS5 proxy on port `9050`.
- **Automatic Reconnection**: Ensures that Tor reconnects automatically in case of disconnection.
- **Healthcheck**: Regularly checks the health of the Tor service and restarts it if necessary.

## Usage

### Build the Docker Image
To build the Docker image from the Dockerfile, run the following command:

```bash
docker build -t tor-proxy .
```

### Run the Docker Container
To run the Docker container, use the following command:

```bash
docker run -d -p 9050:9050 --name tor-proxy wafy80/tor
```

### Using the Tor Proxy
Once the container is running, you can configure your applications to use the Tor proxy. For example, using `curl`:

```bash
curl --socks5-hostname 127.0.0.1:9050 http://check.torproject.org/
```

This command should indicate that your request is routed through the Tor network.

### HTTP Proxy Support

This image also provides an HTTP proxy via Privoxy on port `8118`, which forwards traffic to the Tor SOCKS5 proxy. This is useful for applications that don't support SOCKS5 natively.

```bash
# Using the HTTP proxy
curl --proxy http://127.0.0.1:8118 https://check.torproject.org/

# Docker run with both ports
docker run -d -p 9050:9050 -p 8118:8118 --name tor-proxy wafy80/tor
```

⚠️ The HTTP proxy on port 8118 is a simple forwarder to SOCKS5. For DNS leak protection, prefer --socks5-hostname when possible, or ensure your client resolves hostnames remotely.

## Healthcheck
The Docker image includes a healthcheck that verifies the Tor service is running correctly. The healthcheck is configured as follows:
- **Interval**: Every 30 seconds.
- **Timeout**: 10 seconds.
- **Retries**: 3 attempts before marking the container as unhealthy.

### Checking Health Status
You can check the health status of the container using the following command:

```bash
docker inspect tor-proxy-container
```

Look for the `State` and `Health` sections in the output JSON to see the health status of the container.

## Contributing
Contributions are welcome! If you have any improvements or bug fixes, feel free to open a pull request.

## License
This Docker image is licensed under the [WTFPL License](LICENSE).
