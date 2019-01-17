FROM nginx:latest

COPY run.sh /usr/local/nginx/run.sh

RUN chmod +x /usr/local/nginx/run.sh

CMD ["/usr/local/nginx/run.sh"]
