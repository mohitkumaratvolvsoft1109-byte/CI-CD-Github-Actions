FROM node:24-alpine AS deps
WORKDIR /app
COPY package*.json .
RUN npm ci --only=production

FROM node:24-alpine AS runner
RUN apk add --no-cache openssh-server && \
    ssh-keygen -A && \
    mkdir /var/run/sshd && \
    echo "root:password" | chpasswd && \
    ssh-keygen -A
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN adduser -D -s /bin/sh developer && \
    echo "developer:password" | chpasswd
EXPOSE 3000 22
ENTRYPOINT [ "npm", "run", "dev" ]
CMD ["/usr/sbin/sshd", "-D"]
