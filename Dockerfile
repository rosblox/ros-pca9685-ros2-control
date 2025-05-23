ARG ROS_DISTRO=humble

FROM ros:${ROS_DISTRO}-ros-core

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libi2c-dev \
    python3-colcon-common-extensions \
    ros-${ROS_DISTRO}-hardware-interface \
    ros-${ROS_DISTRO}-hardware-interface-testing \
    ros-${ROS_DISTRO}-controller-manager \
    ros-${ROS_DISTRO}-velocity-controllers \
    ros-${ROS_DISTRO}-joint-state-broadcaster \
    ros-${ROS_DISTRO}-robot-state-publisher \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-tf2 \
    ros-${ROS_DISTRO}-tf2-msgs \
    && rm -rf /var/lib/apt/lists/*

COPY ros_entrypoint.sh .

WORKDIR /colcon_ws
COPY pca9685_ros2_control src/pca9685_ros2_control

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && colcon build --symlink-install --event-handlers console_direct+

ENV LAUNCH_COMMAND='ros2 launch pca9685_ros2_control_example joint_group_velocity_example.launch.py'

# Create build and run aliases
RUN echo 'alias build="colcon build --symlink-install  --event-handlers console_direct+"' >> /etc/bash.bashrc && \
echo 'alias run="su - ros --whitelist-environment=\"ROS_DOMAIN_ID\" /run.sh"' >> /etc/bash.bashrc && \
echo "source /colcon_ws/install/setup.bash; echo UID: $UID; echo ROS_DOMAIN_ID: $ROS_DOMAIN_ID; $LAUNCH_COMMAND" >> /run.sh && chmod +x /run.sh