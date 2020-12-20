#!/bin/bash
# This script setups a local machine running a gzclient accessing the master
# which is running a gzserver and roscore
export ROS_MASTER_URI=http://seilon-3:11311
export ROS_IP=`hostname -I | awk '{print $1}'`
export ROS_HOSTNAME=$ROS_IP
#export GAZEBO_MASTER_URI=http://seilon-3:11346
#export GAZEBO_IP=`hostname -I | awk '{print $1}'`
export IGN_RELAY=`nslookup seilon-3 | grep Address | tail -1 | awk '{print $2}'`
export IGN_IP=`hostname -I | awk '{print $1}'`
export IGN_PARTITION=relay
