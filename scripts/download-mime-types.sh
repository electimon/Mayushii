#!/bin/sh
dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
wget "https://raw.githubusercontent.com/apache/httpd/refs/heads/trunk/docs/conf/mime.types" -O "$dir/../srcs/mime.types"
echo Done