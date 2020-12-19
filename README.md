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




