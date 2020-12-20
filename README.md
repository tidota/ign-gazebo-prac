# Practice for Ignition Gazebo

This repository is just my personal practice for Ignition Gazebo.
https://ignitionrobotics.org/libs/gazebo

# ROS
The simulator is run with ROS.
[ROS Integration](https://ignitionrobotics.org/docs/citadel/ros_integration)

[ros\_ign\_gazebo](https://github.com/ignitionrobotics/ros_ign/tree/melodic/ros_ign_gazebo)

# Model

Apparently, it is recommended to upload models to their Fuel server so that they can be shared.
[Importing a Mesh to Fuel](https://ignitionrobotics.org/api/gazebo/3.2/meshtofuel.html)

## To load a local model/mesh file

<S>Seems like it is impossible to load a model stored in a local machine.
It is required to publish a model to Fuel so that it can be loaded from their server.</S>
It is possible by setting `IGN_GAZEBO_RESOURCE_PATH` to the directory holding the model files.
For example, if it is set to `$(env HOME)/.gazebo/models`, Ignition Gazebo will be able to use the same models that Gazebo classic is also using.
Another way is to make `models` directory under `~/.ignition` and set `IGN_GAZEBO_RESOURCE_PATH` to `$(env HOME)/.ignition/models` as this repository does.

# Network settings for multiple machines

If the server is running on a remote machine, some environment variables must be set.

- `IGN_RELAY`: the IP address of the machine on which the server is running.
- `IGN_IP`: the machine's IP address.
- `IGN_PARTITION`: just set it to `relay` (it may be necessary?)

ROS1 also needs these variables.
- `ROS_MASTER_URI`
- `ROS_IP`
- `ROS_HOSTNAME`

For more details, check the `scripts/network_setup.sh`

# If the local machine is behind NAT (under consideration. Maybe, it is impossible for Ignition Gazebo)

The GUI seems to display the simulation but does not allow any manipulation.
Apparently, it is due to its requirement to receive UDP packets from the server, which are blocked by NAT.

## First attempt (based on the old method used for Gazebo-classic)
If the client is running on a local machine which is behind NAT, reverse SSH tunnel and sshuttle used to work for Gazebo-classic.

Ignition Gazebo seems to also use UDP in addition to TCP while the method of reverse SSH tunnel and sshuttle cannot tunnel UDP packets.

### To enable sshuttle to support UDP packets

TPROXY is required for sshuttle.
https://sshuttle.readthedocs.io/en/v0.76/usage.html
Then, it should pass UDP packets.
```
sudo sshuttle --method=tproxy --dns -r tidota@localhost:2222 10.24.5.0/24
```

### To enable reverse SSH tunnel to support UDP packets

The UDP packets must be temporarily converted to TCP when they are actually passes through the tunnel.
`socat` is required to do this.
http://blog.heyzimo.com/ssh-tunnels-udp-tcp/

Assuming there are TWO reverse SSH tunnels: remote:2222 to local:22 and remote:2223 to local:23

On the remote machine,
```
socat -T15 -U udp4-recvfrom:2222,reuseaddr,fork tcp:localhost:2223
```
On the local machine,
```
socat -U tcp4-listen:23,reuseaddr,fork UDP:localhost:22
```

But it was not successful. It seems to be impossible to pass UDP packets from multiple ports to the other multiple ports by this method.

## Second attempt

How about `pwnat`?
https://github.com/samyk/pwnat

Is this too old?
https://superuser.com/questions/777353/ssh-and-pwnat-for-ssh-connection-between-two-separate-nats
seems like it would not work...

## To check if it is working:

On the local machine,
```
netcat -u -l 8000
```

On the remote machine,
```
netcat -u <the local machine's IP> 8000
```
Then, type something and hit the enter.

If the same message appears on the local machine, it is working with UDP.


## at this point as of 12/19/2020

well, UDP tunnel through NAT for arbitrary port #s may be impossible...

`ssh -Y` to run the gui on the remote server also crashes.

The only possible way may be remote desktop while the response is really bad.

