docker build -t alpine_nginx .
docker run -itd -p 80:80 alpine_nginx

