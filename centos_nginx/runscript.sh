docker build -t centos_nginx .
docker run -itd -p 80:80 centos_nginx

