-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {


  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "laser",
  published_frame = "base_link",
  odom_frame = "odom",
  provide_odom_frame = true,
  publish_frame_projected_to_2d = false,
  use_odometry = false,
  use_nav_sat = false,
  use_landmarks = false,
  num_laser_scans = 1,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 1,
  num_point_clouds = 0,
  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,

  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1,
  imu_sampling_ratio = 1,
  landmarks_sampling_ratio = 1.,
}

MAP_BUILDER.use_trajectory_builder_2d = true
TRAJECTORY_BUILDER_2D.use_imu_data = false
--TRAJECTORY_BUILDER_2D.num_accumulated_range_data = 10

TRAJECTORY_BUILDER_2D.submaps.num_range_data =20  --存的帧数太多在旋转时累计误差比较大，submap质量会变差
TRAJECTORY_BUILDER_2D.min_range = 0.25   
TRAJECTORY_BUILDER_2D.max_range =9 --旋转时远处的点云在产生畸变影响定位的精度，且远处反光率低的物体探测性能下降

POSE_GRAPH.optimize_every_n_nodes = 10
POSE_GRAPH.constraint_builder.min_score = 0.65

TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching =true   --没有imu,odom等其他信息，
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.25
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.translation_delta_cost_weight = 1e-1  -- 1e-1
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.rotation_delta_cost_weight = 1e-1   --1e-1
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.angular_search_window = math.rad(30.) 

--每过30秒，或者每前进两米，或者转75度 生成一幅submap ，及时消除累计误差，提高定位精度。
TRAJECTORY_BUILDER_2D.motion_filter.max_time_seconds=30/TRAJECTORY_BUILDER_2D.submaps.num_range_data
TRAJECTORY_BUILDER_2D.motion_filter.max_distance_meters=2/TRAJECTORY_BUILDER_2D.submaps.num_range_data
TRAJECTORY_BUILDER_2D.motion_filter.max_angle_radians 
        = math.rad(75/TRAJECTORY_BUILDER_2D.submaps.num_range_data/POSE_GRAPH.optimize_every_n_nodes)



return options
