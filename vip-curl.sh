#!/bin/bash

gnome-terminal --title=server1 --geometry=25x2+1900+0 --command="./curl_lb.sh https://server1.example.com/health.html"
gnome-terminal --title=server2 --geometry=25x2+1900+120 --command="./curl_lb.sh https://server2.example.com/health.html"
gnome-terminal --title=load-balancer --geometry=25x2+1900+215 --command="./curl_lb.sh https://loadbalancer.example.com/health.html"
