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
    ros-humble-tf2 \
    ros-humble-tf2-msgs \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /colcon_ws
COPY pca9685_ros2_control src/pca9685_ros2_control
COPY ros2_controllers/diff_drive_controller src/ros2_controllers/diff_drive_controller

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && colcon build --symlink-install --event-handlers console_direct+

COPY ros_entrypoint.sh ..

RUN echo 'alias build="colcon build --symlink-install  --event-handlers console_direct+"' >> ~/.bashrc
RUN echo 'source /colcon_ws/install/setup.bash; ros2 launch pca9685_ros2_control_example mixed_example.launch.py' >> /run.sh && chmod +x /run.sh
RUN echo 'alias run="su - ros /run.sh"' >> /etc/bash.bashrc

