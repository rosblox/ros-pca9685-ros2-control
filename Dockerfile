ARG ROS_DISTRO

FROM ros:${ROS_DISTRO}-ros-core

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libi2c-dev \
    python3-colcon-common-extensions \
    ros-humble-hardware-interface \
    ros-humble-controller-manager \
    ros-humble-velocity-controllers \
    ros-humble-xacro \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /colcon_ws/src
COPY pca9685_ros2_control pca9685_ros2_control

WORKDIR /colcon_ws

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && colcon build --symlink-install --event-handlers console_direct+

WORKDIR /

COPY ros_entrypoint.sh .

RUN echo 'alias build="colcon build --cmake-args --symlink-install  --event-handlers console_direct+"' >> ~/.bashrc
RUN echo 'alias run_joint_group_velocity="ros2 launch pca9685_ros2_control_example joint_group_velocity_example.launch.py"' >> ~/.bashrc
RUN echo 'alias run_diff_drive="ros2 launch pca9685_ros2_control_example diff_drive_example.launch.py"' >> ~/.bashrc
