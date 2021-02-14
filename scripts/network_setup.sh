#!/bin/bash
# This script setups a local machine running a gzclient accessing the master
# which is running a gzserver and roscore
SERVER_NAME=seilon-3

# settings for ROS
export ROS_MASTER_URI=http://$SERVER_NAME:11311
export ROS_IP=`hostname -I | awk '{print $1}'`
export ROS_HOSTNAME=$ROS_IP

# settings for ignition gazebo
# reference: https://ignitionrobotics.org/api/transport/8.1/relay.html
export IGN_RELAY=`nslookup $SERVER_NAME | grep Address | tail -1 | awk '{print $2}'`
export IGN_IP=`hostname -I | awk '{print $1}'`
export IGN_PARTITION=relay
