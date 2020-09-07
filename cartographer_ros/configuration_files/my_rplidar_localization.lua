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
TRAJECTORY_BUILDER.pure_localization_trimmer = {
  max_submaps_to_keep = 3, --如果不存少量的submap，在对称的环境中容易发生闭环检测位置跳变
}

TRAJECTORY_BUILDER_2D.use_imu_data = false
TRAJECTORY_BUILDER_2D.max_range =10
if(TRAJECTORY_BUILDER_2D.use_imu_data) --如果有imu则可以用imu的信息缩小match范围，提高match速度
then
  use_online_correlative_scan_matching = false
  TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight=1
  TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 10.
  TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.num_threads=7
end

POSE_GRAPH.optimize_every_n_nodes = 3 --每几幅submap做一次全局优化，频率太高的话会阻塞
POSE_GRAPH.constraint_builder.min_score = 0.6
POSE_GRAPH.constraint_builder.sampling_ratio=0.2
POSE_GRAPH.constraint_builder.loop_closure_rotation_weight = 1e7

POSE_GRAPH.constraint_builder.ceres_scan_matcher.translation_weight = 1e1 --10
POSE_GRAPH.constraint_builder.ceres_scan_matcher.rotation_weight=1e5
POSE_GRAPH.constraint_builder.ceres_scan_matcher.ceres_solver_options.num_threads=7

POSE_GRAPH.global_sampling_ratio=0.002
POSE_GRAPH.matcher_rotation_weight=1e-1
POSE_GRAPH.optimization_problem.rotation_weight=3e8  
POSE_GRAPH.optimization_problem.acceleration_weight=1e1



return options
