#!/bin/bash
warp-cli connect
cd Downloads
sudo openvpn emanadel2532004.ovpn
ping 10.10.10.10
sleep(4)
echo "done!"
warp-cli disconnect
