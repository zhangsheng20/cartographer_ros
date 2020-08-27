run mavros:
```
cd ~mavros_ws/
source devel/setup.bash
roslaunch mavros px4.launch
```


call_cartographer_service:
```
rosrun call_cartographer_service call_cartographer_service
```


offline map create:
```
roslaunch cartographer_ros my_offline_rplidar.launch bag_filenames:=${HOME}/Desktop/bag/2020-08-18-17-25-28.bag
```



```
extract data
```
rostopic echo -b ${HOME}/Desktop/2020-07-30-10-31-14.bag -p /UgvOdomTopic > ugvodomtopic2.txt
```

compile cartographer:
```
catkin_make_isolated --install --use-ninja
catkin_make -DCATKIN_WHITELIST_PACKAGES="rplidar_src"
```

run rplidar_ros:
```
source ~/rplidar_ws/devel/setup.bash
roslaunch rplidar_ros rplidar_a3.launch
```

run cartographer_ros:
```
source ~/cartographer_ws/install_isolated/setup.bash

roslaunch cartographer_ros demo_revo_lds.launch
roslaunch cartographer_ros demo_backpack_3d.launch bag_filename:=${HOME}/Downloads/b3-2016-04-05-14-14-00.bag
roslaunch cartographer_ros my_rslidar.launch
```

run in simulator of yzchen:
```
roslaunch cartographer_ros my_rplidar_sim.launch 
```

run in pure_localization simulator of yzchen:
```
roslaunch cartographer_ros my_rplidar_localization_sim.launch 
```

run in a bag:
```
2d :roslaunch cartographer_ros my_demo_rplidar.launch bag_filename:=${HOME}/Desktop/bag/2020-07-27-20-25-08.bag
2d: roslaunch cartographer_ros my_demo_rplidar.launch bag_filename:=${HOME}/Desktop/bag/2020-07-28-20-10-15.bag
3d: roslaunch cartographer_ros my_demo_rslidar.launch bag_filename:=${HOME}/Desktop/bag/2020-07-29-17-01-24.2.bag

2d with imu:
roslaunch cartographer_ros my_demo_rplidar_useimu.launch  bag_filename:=${HOME}/Desktop/bag/2020-08-13-18-27-52.bag
```

run in a google's bag:
```
roslaunch cartographer_ros demo_backpack_2d.launch bag_filename:=${HOME}/Downloads/cartographer_paper_deutsches_museum.bag
```

pure_localization sim:
```
roslaunch cartographer_ros my_demo_rplidar_localization.launch  load_state_filename:=${HOME}/.ros/test001.pbstream bag_filename:=${HOME}/Desktop/2020-07-27-20-25-08.bag

roslaunch cartographer_ros my_demo_rplidar_localization.launch  load_state_filename:=${HOME}/.ros/test001.pbstream bag_filename:=${HOME}/Desktop/bag/2020-07-28-20-10-15.bag  

use imu:
roslaunch cartographer_ros my_demo_rplidar_localization_useimu.launch  load_state_filename:=${HOME}/.ros/test001.pbstream bag_filename:=${HOME}/Desktop/bag/2020-07-28-20-10-15.bag


2020-08-13-18-27-52.bag
2020-07-28-20-10-15.bag
```

pure_localization sim: in new place
```
roslaunch cartographer_ros my_demo_rplidar_localization.launch load_state_filename:=${HOME}/Desktop/bag/2020-08-18-17-39-34.bag.pbstream bag_filename:=${HOME}/Desktop/bag/2020-08-18-17-34-12.bag
```

pure_localization :
```
roslaunch cartographer_ros my_rplidar_localization.launch load_state_filename:=${HOME}/Desktop/bag/2020-08-26-17-35-29.bag.pbstream
```