ARG ROS_DISTRO

FROM ros:${ROS_DISTRO}-ros-core

# RUN apt update && apt install -y --no-install-recommends \\
# python3-rpi.gpio python3-pip \\
# python3-colcon-common-extensions && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    ros-humble-hardware-interface \
    ros-humble-controller-manager \
    ros-humble-velocity-controllers \
    ros-humble-xacro \
    libi2c-dev


WORKDIR /colcon_ws/src
COPY pca9685_ros2_control pca9685_ros2_control

WORKDIR /colcon_ws

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && colcon build --symlink-install --event-handlers console_direct+

WORKDIR /

COPY ros_entrypoint.sh .

RUN echo 'alias build="colcon build --cmake-args --symlink-install  --event-handlers console_direct+"' >> ~/.bashrc
RUN echo 'alias run="ros2 launch pca9685_ros2_control_example example.launch.py"' >> ~/.bashrc
