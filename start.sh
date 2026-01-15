#!/bin/sh
# Start SSH in background
/usr/sbin/sshd -D &
# Start Node.js server
cd /app && npm start
