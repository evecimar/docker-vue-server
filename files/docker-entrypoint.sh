#!/bin/bash
set -e

git=$git_url
nginx=$nginx_conf_url
command=$custom_command_url
project_dir="/var/www/app"

shopt -s dotglob nullglob

cd /var/www/app/

if [ ! -z $git ]
then
    cd /var/www/app/

    if [ -z $git_branch ]
        then
        git_branch=master
    fi
    git clone -b $git_branch $git_url

    repo_url=$git_url
    repo=${repo_url##*/}
    project_dir=/var/www/app/${repo%%.git*}
    mv $project_dir/* /var/www/app/
    
    file="docker/nginx.conf"
    if [ -f "$file" ]
    then
        mv docker/nginx.conf /etc/nginx/nginx.conf
    fi
    
    file="docker/custom-command.sh"
    if [ -f "$file" ]
    then
        mv docker/custom-command.sh /custom-command.sh
        chmod +x /custom-command.sh
        /custom-command.sh
    fi

fi

if [ ! -z $nginx ]
then
    rm /nginx.conf
    wget -O /nginx.conf $nginx_conf_url
    mv /nginx.conf /etc/nginx/nginx.conf
fi

if [ ! -z $command ]
then
    rm /start.sh
    wget -O /start.sh $custom_command_url
    chmod +x /start.sh
    /start.sh
fi

/usr/sbin/nginx -g "daemon off;"
