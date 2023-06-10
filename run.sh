#!/bin/bash

docker run -it --net=host --device=/dev/i2c-1:/dev/i2c-1 --volume $(pwd)/pca9685_ros2_control:/colcon_ws/src/pca9685_ros2_control --entrypoint=/bin/bash ghcr.io/rosblox/ros-pca9685-ros2-control:humble 

