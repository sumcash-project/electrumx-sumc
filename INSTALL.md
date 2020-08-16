# How to install ElectrumX for Sumcoin using the ElectrumX installer script
This guide assumes you have Sumcoind running and synced with the Sumcoin blockchain with RPC credentials set and transaction indexing enabled.

## Step 1 - Download the script
Clone the script:   

```
git clone https://github.com/bauerj/electrumx-installer.git
```

Navigate into the directory were you cloned the script: 

```
cd electrumx-installer
```

## Step 2 - Run the script
Now run the script to install ElectrumX with Sumcoin:   

```
sudo bash ./install.sh --electrumx-git-url https://github.com/sumcoinlabs/electrumx-sum.git
```

* Let the script install all required dependencies and install ElectrumX (this takes about 2-5 minutes).

### You should get the following:

```
Installing installer dependencies                                                                           
Adding new user for electrumx                                                                           
Creating database directory in /db                                                                           
INFO:    Python 3.6 is already installed.
Installing git                                                                           
Installing RocksDB                                                                           
Installing pyrocksdb                                                                           
Checking pyrocksdb installation                                                                           
Installing electrumx                                                                           
Installing init scripts                                                                           
INFO:    Use service electrumx start to start electrumx once it's configured
Generating TLS certificates                                                                           
INFO:    electrumx has been installed successfully. Edit /etc/electrumx.conf to configure it....
```

* You are now done with the Installer.   'cd' to root 

## Create a self-signed SSL cert
*[Note: SSL certificates signed by a CA are supported by 2.0 clients.]

To run SSL / HTTPS you need to generate a self-signed certificate using openssl. You could just comment out the SSL / HTTPS ports in the config and run without, but this is not recommended.

### Make a data directory to make the server keys in

```
mkdir ~/.electrumx
```
Synchronizing with a Sumcoin node takes anywhere between 3-9 hours depending on your hardware.

If you want to speed up the process a bit, download one of these data files and put it in the ~/.electrumx folder.

## Create a self-signed certificate
To allow Electrum wallets to connect to your server over SSL you need to create a self-signed certificate.

Go to the data folder:
```
cd ~/.electrumx
```

and generate your key:

Use the sample code below to create a self-signed cert with a recommended validity of 5 years. You may supply any information for your sign request to identify your server. They are not currently checked by the client except for the validity date. When asked for a challenge password just leave it empty and press enter.

```
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr
```

Follow the on-screen information. It will ask for certificate details such as your country and password. You can leave those fields empty.

When done, create a certificate:

```
openssl x509 -req -days 1825 -in server.csr -signkey server.key -out server.crt
```
These commands will create 2 files: server.key and server.crt.

When configuring the ElectrumX instance, make sure to add server.key to SSL_KEYFILE and server.crt to SSL_CERTFILE. More on this in the next step.



The server.crt file is your certificate suitable for the ssl_certfile= parameter and server.key corresponds to ssl_keyfile= in your Electrum server config.

Starting with Electrum 1.9, the client will learn and locally cache the SSL certificate for your server upon the first request to prevent man-in-the middle attacks for all further connections.

If your certificate is lost or expires on the server side, you will need to run your server with a different server name and a new certificate. Therefore it's a good idea to make an offline backup copy of your certificate and key in case you need to restore them.



## Step 3 - Configure ElectrumX for Sumcoin

Electrum reads a config file (/etc/electrum.conf) when starting up. This file includes the database setup, sumcoind RPC setup, and a few other options.

The "configure" script listed above will create a config file at /etc/electrum.conf which you can edit to modify the settings.

Go through the config options and set them to your liking. If you intend to run the server publicly have a look at README-IRC.md

Edit the ElectrumX configuration file:  
```
sudo nano /etc/electrumx.conf
```

* Here's how the configuration file should look: 

```
# default /etc/electrumx.conf for systemd
COIN = Sumcoin
NET = mainnet

# REQUIRED
DB_DIRECTORY = /db
# Sumcoin Node RPC Credentials
DAEMON_URL = http://<RPCUSER>:<RPCPASSWORD>@localhost:3332/


# See http://electrumx.readthedocs.io/en/latest/environment.html for
# information about other configuration settings you probably want to consider.

DB_ENGINE=rocksdb

SSL_CERTFILE=/etc/electrumx/server.crt
SSL_KEYFILE=/etc/electrumx/server.key
TCP_PORT=53332
SSL_PORT=53333
# Listen on all interfaces:
HOST=127.0.0.1
```

Note: replace `<RPCUSER>` with your Sumcoind RPC username and `<RPCPASS>` with your RPC password.

## Step 4 - Start ElectrumX
Start ElectrumX by running: 

`service electrumx start`

Check the logs and indexing progress of ElectrumX with: 

`journalctl -u electrumx -f`

If everything installed correctly, you should see ElectrumX properly syncs with your Sumcoin node and listens for incoming connections.


