.. image:: https://travis-ci.org/kyuupichan/electrumx.svg?branch=master
    :target: https://travis-ci.org/kyuupichan/electrumx
.. image:: https://coveralls.io/repos/github/kyuupichan/electrumx/badge.svg
    :target: https://coveralls.io/github/kyuupichan/electrumx

===========================================================
ElectrumX - Reimplementation of electrum-server for Sumcash
===========================================================

For a future network with bigger blocks.

  :Licence: MIT
  :Language: Python (>= 3.6)
  :Author: Neil Booth

Documentation
=============

See `readthedocs <https://electrumx.readthedocs.io/>`_.


**Neil Booth**  kyuupichan@gmail.com  https://github.com/kyuupichan

## Quick start commands

Start ElectrumX by running:

`service electrumx start`

Check the logs and indexing progress of ElectrumX with:

`journalctl -u electrumx -f`

If everything installed correctly, you should see ElectrumX properly syncs with your Sumcash node and listens for incoming connections.
