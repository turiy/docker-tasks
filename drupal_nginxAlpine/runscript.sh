docker build -t alpine_nginx .
docker run -itd -p 80:8080 alpine_nginx

