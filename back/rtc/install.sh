#!/bin/bash

sudo apt-get -y update
sudo apt-get install coturn

rm /etc/turnserver.conf
rm /etc/default/coturn

mv ~/turnserver.conf /etc/turnserver.conf
mv ~/coturn /etc/default/coturn

systemctl start coturn
