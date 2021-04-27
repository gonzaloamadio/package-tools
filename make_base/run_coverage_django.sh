#!/bin/bash

# References
# https://adamj.eu/tech/2019/04/30/getting-a-django-application-to-100-percent-coverage/

echo coverage run manage.py test
coverage run manage.py test || true
coverage html


GREEN='\033[0;32m'
NC='\033[0m' # No Color
echo;echo;
printf "To see the coverage report execute: ${GREEN}coverage report${NC}\n"
printf "To see a better and interactive html report, open ${GREEN}htmlconv/index.html${NC}\n"
echo;echo;

open htmlcov/index.html
