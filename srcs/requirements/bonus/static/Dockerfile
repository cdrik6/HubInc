FROM debian:bullseye

RUN apt-get update \ 
    && apt-get install -y node.js npm \
    && rm -rf /var/lib/apt/lists/*

COPY /tools /home/app

WORKDIR /home/app

RUN npm init -y && npm install -y express

CMD ["node", "server.js"]

# Express sits on top of Node.js and handles HTTP requests, processes data, and sends responses.
# --> Static File Serving – Serve HTML, CSS, JS, images easily.