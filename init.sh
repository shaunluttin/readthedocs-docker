#!/bin/bash 

set -e  

echo "Starting SSH ..." 

service ssh start  

python /readthedocs/manage.py runserver 0.0.0.0:5000
