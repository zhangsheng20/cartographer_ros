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

include "my_rplidar.lua"


POSE_GRAPH.optimize_every_n_nodes = 10
POSE_GRAPH.constraint_builder.min_score = 0.65

TRAJECTORY_BUILDER_2D.use_imu_data = true

TRAJECTORY_BUILDER_2D.submaps.num_range_data =20
TRAJECTORY_BUILDER_2D.min_range = 0.25
TRAJECTORY_BUILDER_2D.max_range =8

TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching =true
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.3
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.translation_delta_cost_weight = 1e-1 -- 1e-1
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.rotation_delta_cost_weight = 1e-1   --1e-1
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.angular_search_window = math.rad(20.)

TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight=1e0  -- 10
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 4e5    --40
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.num_threads=4


TRAJECTORY_BUILDER_2D.motion_filter.max_time_seconds=30/TRAJECTORY_BUILDER_2D.submaps.num_range_data
TRAJECTORY_BUILDER_2D.motion_filter.max_distance_meters=4/TRAJECTORY_BUILDER_2D.submaps.num_range_data
TRAJECTORY_BUILDER_2D.motion_filter.max_angle_radians=math.rad(5)
--rad(180/TRAJECTORY_BUILDER_2D.submaps.num_range_data/POSE_GRAPH.optimize_every_n_nodes)





return options
