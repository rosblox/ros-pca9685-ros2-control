ARG ROS_DISTRO

FROM ros:${ROS_DISTRO}-ros-core

RUN apt update && apt install -y --no-install-recommends python3-rpi.gpio python3-pip python3-colcon-common-extensions && rm -rf /var/lib/apt/lists/*

RUN pip3 install adafruit-circuitpython-pca9685 adafruit-circuitpython-servokit

WORKDIR /colcon_ws/src
COPY ros_pca9685 ros_pca9685

WORKDIR /colcon_ws

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && colcon build --symlink-install

WORKDIR /

COPY ros_entrypoint.sh .

RUN echo 'alias build="colcon build --cmake-args --symlink-install  --event-handlers console_direct+"' >> ~/.bashrc
RUN echo 'alias run="ros2 run ros_pca9685 ros_pca9685_subscriber"' >> ~/.bashrc
