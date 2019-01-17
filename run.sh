#!/bin/bash

echo "LoadBalancer DNS: $SERVER_NAME"
echo "LoadBalancer Port: $PORT"
echo "K8s Service Port: $SERVICE_PORT"


cat <<EOF > /etc/nginx/nginx.conf
worker_processes  4;  

events {
    worker_connections  1024;
}

http {
        sendfile on; 
        tcp_nopush on; 
        tcp_nodelay on; 
        keepalive_timeout 65; 
        types_hash_max_size 2048;

        include mime.types;
        default_type application/octet-stream;

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        real_ip_header X-Forwarded-For;
        set_real_ip_from 0.0.0.0/0;

        gzip on; 
        gzip_disable "msie6";
        include /etc/nginx/sites-enabled/*;
}
EOF

mkdir -p /etc/nginx/sites-enabled

cat <<EOF > /etc/nginx/sites-enabled/default

   upstream stream_backend {
EOF

for NODE in "${!NODE_@}"; do
  echo "Adding Node: ${!NODE}"
  echo "       server ${!NODE}:$SERVICE_PORT;" >> /etc/nginx/sites-enabled/default
done

cat <<EOF >> /etc/nginx/sites-enabled/default
    }
    server {
	  listen $PORT;
	  location / {
	    proxy_pass http://stream_backend;
	  }
    }

EOF

cp /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf

echo "LoadBalancer Configured Successfully!"

/usr/sbin/nginx -g "daemon off;"

