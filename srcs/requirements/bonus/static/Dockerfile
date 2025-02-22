FROM debian:bullseye

COPY tools/init_static.sh /init_static.sh

RUN bash ./init_static.sh

# ENTRYPOINT ["bash", "init_static.sh"]
CMD ["tail", "-f", "/dev/null"]