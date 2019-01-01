#!/usr/bin/env bash

install_docker() {
  sudo yum update -y
  echo '*** finished update'
  ps aux | grep yum | xargs kill -9
  sudo amazon-linux-extras install docker -y
  echo '*** installed docker'
  sudo service docker start
  echo '*** started docker'
}

start_echo_server() {
  sudo docker run -p 80:80 -e PORT=80 --rm -t -d solsson/http-echo
  echo '*** started echo server container and binded port 80'
}

install_docker
start_echo_server
