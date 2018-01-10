#!/bin/bash

if [ -n "$1" ]; then
   export http_proxy=$1
   export https_proxy=$1
   export no_proxy='no_proxy=localhost,127.0.0.1'
   echo 'http_proxy="'"$1"'"' >> /etc/environment
   echo 'https_proxy="'"$1"'"' >> /etc/environment
   echo 'ftp_proxy="'"$1"'"' >> /etc/environment
   echo 'no_proxy="localhost,127.0.0.1"' >> /etc/environment
   . /etc/environment
   touch /etc/apt/apt.conf
   echo 'acquire::http::proxy "'"$1"'";' >> /etc/apt/apt.conf
   echo 'acquire::https::proxy "'"$1"'";' >> /etc/apt/apt.conf
   echo 'acquire::ftp::proxy "'"$1"'";' >> /etc/apt/apt.conf
fi
