Install：
    mkdir cartographer_ros_ws
    cd cartographer_ros_ws
    mkdir src
    cd src
    git clone https://github.com/zhangsheng20/cartographer_ros.git
    git clone https://github.com/zhangsheng20/cartographer.git 
    git clone https://ceres-solver.googlesource.com/ceres-solver.git 

    cartographer/scripts/install_proto3.sh
    sudo rosdep init
    rosdep update
    rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

    cartographer/scripts/install_abseil
    catkin_make_isolated --install --use-ninja



launch mavros:
    cd ~mavros_ws/
    source devel/setup.bash
    roslaunch mavros px4.launch

launch call_cartographer_service: （used to initialize pose and monitor SLAM ）
    rosrun call_cartographer_service call_cartographer_service


launch rplidar_ros:
    source ~/rplidar_ws/devel/setup.bash
    roslaunch rplidar_ros rplidar_a3.launch

source cartographer_ros:
    source ~/cartographer_ws/install_isolated/setup.bash

run directly :
    2D: roslaunch cartographer_ros my_rplidar.launch
    3D: roslaunch cartographer_ros my_rslidar.launch
    
run with a bag:
    2D: roslaunch cartographer_ros my_demo_rplidar.launch bag_filename:=${HOME}/Desktop/bag/2020-07-28-20-10-15.bag
    3D: roslaunch cartographer_ros my_demo_rslidar.launch bag_filename:=${HOME}/Desktop/bag/2020-07-29-17-01-24.2.bag
    2D with imu:roslaunch cartographer_ros my_demo_rplidar_useimu.launch  bag_filename:=${HOME}/Desktop/bag/2020-08-13-18-27-52.bag

run pure_localization :
    roslaunch cartographer_ros my_rplidar_localization.launch load_state_filename:=${HOME}/Desktop/bag/2020-08-26-17-35-29.bag.pbstream

run pure_localization with a bag: 
    roslaunch cartographer_ros my_demo_rplidar_localization.launch load_state_filename:=${HOME}/Desktop/bag/2020-08-18-17-39-34.bag.pbstream bag_filename:=${HOME}/Desktop/bag/2020-08-18-17-34-12.bag



offline map create:
    roslaunch cartographer_ros my_offline_rplidar.launch bag_filenames:=${HOME}/Desktop/bag/2020-08-18-17-25-28.bag

extract data:
    rostopic echo -b ${HOME}/Desktop/2020-07-30-10-31-14.bag -p /UgvOdomTopic > ugvodomtopic2.txt

run in simulator of yzchen:
    roslaunch cartographer_ros my_rplidar_sim.launch 

run in pure_localization simulator of yzchen:
    roslaunch cartographer_ros my_rplidar_localization_sim.launch 