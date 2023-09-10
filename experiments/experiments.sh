
docker run --gpus=all -it --rm -e DISPLAY -v /dev/dri:/dev/dri:ro -v /tmp/.X11-unix:/tmp/.X11-unix:rw cyberbotics/webots:R2023b-ubuntu22.04 webots



docker build -t ros_webots ./ros_docker_base/.
docker run -it --rm -v ./src:/src:Z --workdir /src --network=ros_webots ros_webots 

docker run -it --rm -v ./src:/src:Z --workdir /src ros_webots \
    ros2 pkg create --build-type ament_python --license Apache-2.0 --node-name my_robot_driver my_package --dependencies rclpy geometry_msgs webots_ros2_driver

    cd my_package/
    colcon build
    source install/local_setup.bash
    ros2 launch my_package robot_launch.py

    ls /opt/ros/iron/share/
    