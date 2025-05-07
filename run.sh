#!/bin/bash

REPOSITORY_NAME="$(basename "$(dirname -- "$( readlink -f -- "$0"; )")")"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export HOST_UID=$(id -u)

docker compose -f $SCRIPT_DIR/docker-compose.yml run \
--volume $(pwd)/pca9685_ros2_control:/colcon_ws/src/pca9685_ros2_control \
--volume $(pwd)/ros2_controllers/diff_drive_controller:/colcon_ws/src/ros2_controllers/diff_drive_controller \
${REPOSITORY_NAME} bash
