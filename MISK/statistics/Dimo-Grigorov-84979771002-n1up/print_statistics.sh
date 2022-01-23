#!/bin/bash
default_interface=`route | grep '^default' | grep -o '[^ ]*$'`
while true
do
    tx_bytes=$(</sys/class/net/${default_interface}/statistics/tx_bytes)
    rx_bytes=$(</sys/class/net/${default_interface}/statistics/rx_bytes)
    rx_packets=$(</sys/class/net/${default_interface}/statistics/rx_packets)
    tx_packets=$(</sys/class/net/${default_interface}/statistics/tx_packets)
    tx_errors=$(</sys/class/net/${default_interface}/statistics/tx_errors)
    rx_errors=$(</sys/class/net/${default_interface}/statistics/rx_errors)
    echo '{"tx_bytes": "'"${tx_bytes}"'", "tx_packets": "'"${tx_packets}"'", "tx_errors": "'"${tx_errors}"'", "rx_bytes": "'"${rx_bytes}"'", "rx_packets": "'"${rx_packets}"'", "rx_errors": "'"${rx_errors}"'"}' | python -m json.tool
    sleep 30
done
