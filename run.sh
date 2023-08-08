#!/bin/bash

docker run -it --net=host --device=/dev/i2c-1:/dev/i2c-1 \
--volume $(pwd)/pca9685_ros2_control:/colcon_ws/src/pca9685_ros2_control \
--volume $(pwd)/ros2_controllers/diff_drive_controller:/colcon_ws/src/ros2_controllers/diff_drive_controller \
--ipc=host --pid=host --network=host --env UID=$(id -u) --env GID=$(id -g) \
ghcr.io/rosblox/ros-pca9685-ros2-control:humble 

