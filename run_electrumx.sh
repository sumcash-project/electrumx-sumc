#!/bin/sh
###############
# run_electrumx
###############

# configure electrumx
export COIN=Sumcash
export DAEMON_URL=http://user:password@127.0.0.1:3332/
export NET=mainnet
export CACHE_MB=400
export DB_DIRECTORY=/home/electrumx/.electrumx/db
export SSL_CERTFILE=/home/electrumx/.electrumx/certfile.crt
export SSL_KEYFILE=/home/electrumx/.electrumx/keyfile.key
export BANNER_FILE=/home/electrumx/.electrumx/banner
export DONATION_ADDRESS=your-donation-address

# connectivity
export HOST=
export TCP_PORT=50001
export SSL_PORT=50002

# visibility
export REPORT_HOST=hostname.com
export RPC_PORT=8000

# run electrumx
ulimit -n 10000
/home/electrumx/electrumx/electrumx_server 2>> /home/electrumx/.electrumx/electrumx.log >> /home/electrumx/.electrumx/electrumx.log &

######################
# auto-start electrumx
######################

# add this line to crontab -e
# @reboot /path/to/run_electrumx.sh
