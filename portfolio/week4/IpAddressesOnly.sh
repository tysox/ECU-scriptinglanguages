#!/bin/bash

#Execute the 'IpInfo.sh' script, but only display the lines of text relating to IP Address.
./IpInfo.sh | sed -n '/IP /p'