# Use a minimal Debian-based image as the base image
FROM debian:stable-slim

# Copy the start script into the container
COPY start-tor.sh /start-tor.sh

# Make the start script executable, update package lists, install required packages, clean up, and configure Tor + Privoxy
RUN chmod +x start-tor.sh ; \
 apt update && apt install -y tor privoxy netcat-traditional && apt clean ; \
 echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc ; \
 sed -i 's/^#*listen-address.*/listen-address 0.0.0.0:8118/' /etc/privoxy/config ; \
 echo "forward-socks5 / 127.0.0.1:9050 ." >> /etc/privoxy/config ; \
 echo "debug 0" >> /etc/privoxy/config

# Expose the Tor SOCKS proxy port and Privoxy HTTP proxy port
EXPOSE 9050 8118

# Define a health check to ensure both Tor and Privoxy are running (with startup grace period)
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
 CMD nc -zv localhost 9050 && nc -zv localhost 8118 || exit 1

# Set the default command to execute the start script
CMD ["/start-tor.sh"]
