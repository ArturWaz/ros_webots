FROM cyberbotics/webots:R2023b-ubuntu22.04


### below, copy: FROM ros:iron-ros-core-jammy (https://github.com/osrf/docker_images/blob/bca53bf4c09d771be3ff735da4157203b53ebc2b/ros/iron/ubuntu/jammy/ros-core/Dockerfile)

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup sources.list
RUN echo "deb http://packages.ros.org/ros2/ubuntu jammy main" > /etc/apt/sources.list.d/ros2-latest.list

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO iron

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-iron-ros-core=0.10.0-3* \
    && rm -rf /var/lib/apt/lists/*



### below, copy: FROM ros:iron-ros-base (https://github.com/osrf/docker_images/blob/bca53bf4c09d771be3ff735da4157203b53ebc2b/ros/iron/ubuntu/jammy/ros-base/Dockerfile)

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

# setup colcon mixin and metadata
RUN colcon mixin add default \
      https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update && \
    colcon metadata add default \
      https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
    colcon metadata update

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-iron-ros-base=0.10.0-3* \
    && rm -rf /var/lib/apt/lists/*



RUN apt-get update && apt-get install -y python3-pip ros-iron-webots-ros2 
RUN pip install setuptools==58.2.0


RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /root/.bashrc

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]