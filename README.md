see: http://qiita.com/gongo/items/34dc82521d77f9cc38cd

# Installation and Deploy Memo

だいたいこんな感じ

```
$ yaourt -S heroku-toolbelt docker-compose
$ heroku plugins:install heroku-docker
$ sudo docker daemon -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock
$ export DOCKER_HOST=tcp://0.0.0.0:4243
$ docker-compose build
$ heroku docker:release --app web-doctor-el
$ curl 'https://web-doctor-el.herokuapp.com/?q=(hello)'
```


# Restart

たぶんこれ

```
$ heroku restart --app web-doctor-el
```
