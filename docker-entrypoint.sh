#!/bin/sh
set -e

exec su -s "/bin/sh" -c 'python /opt/npvrproxy/npvrProxy.py' duser
