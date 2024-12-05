FROM ros:jazzy-ros-base
SHELL ["/bin/bash", "-c"]

USER root
COPY . /app/src/rmw_zenoh
WORKDIR /app
RUN apt update &&\
    apt install -y ros-${ROS_DISTRO}-demo-nodes-cpp &&\
    rosdep update &&\
    rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y &&\
    source /opt/ros/${ROS_DISTRO}/setup.bash &&\
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["/app/src/rmw_zenoh/entrypoint.sh"]
