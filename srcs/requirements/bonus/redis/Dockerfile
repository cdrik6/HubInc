FROM debian:bullseye

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y redis-server

# specific settings	of Redis for caching in /etc/redis/redis.conf (big file so not by copy)
# maxmemory 256mb -> tells Redis not to use more than 256MB of RAM
# maxmemory-policy allkeys-lru -> tells Redis what to do when mas is reached:
# Redis will evict the least recently used key to make space (best for caching)
RUN echo "maxmemory 256mb" >> /etc/redis/redis.conf \ 
 && echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf 
#  && sed -i "s|bind 127.0.0.1|# bind 127.0.0.1|g" /etc/redis/redis.conf 
#  && sed -i "s|# port 0|port 0|g" /etc/redis/redis.conf \
#  && sed -i "s|# tls-port 6379|tls-port 6379|g" /etc/redis/redis.conf

EXPOSE 6379
# Expose port to the host

CMD	["redis-server", "--protected-mode no"]