# Use a minimal Debian-based image as the base image
FROM debian:stable-slim

# Copy the start script into the container
COPY start-tor.sh /start-tor.sh

# Make the start script executable, update package lists, install required packages, clean up, and configure Tor
RUN chmod +x start-tor.sh ; \
 apt update && apt install -y tor netcat-traditional && apt clean ; \
 echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc ; \
 echo "HTTPTunnelPort 0.0.0.0:9051" >> /etc/tor/torrc

# Expose the Tor SOCKS proxy port and HTTP tunnel port
EXPOSE 9050 9051

# Define a health check to ensure the Tor service is running and accessible
HEALTHCHECK CMD nc -zv localhost 9050 && nc -zv localhost 9051 || exit 1

# Set the default command to execute the start script
CMD ["/start-tor.sh"]
