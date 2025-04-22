FROM debian:stable-slim
COPY start-tor.sh /start-tor.sh
RUN chmod +x start-tor.sh ; \
    apt update && apt install -y tor netcat-traditional && apt clean ; \
    echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc
EXPOSE 9050
HEALTHCHECK CMD nc -zv localhost 9050 || exit 1
CMD ["/start-tor.sh"]
