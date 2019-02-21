

# %Tag(FULLTEXT)%
cmake_minimum_required(VERSION 2.8.3)
project(data_read)

## Find catkin and any catkin packages
find_package(catkin REQUIRED COMPONENTS roscpp rospy std_msgs geometry_msgs sensor_msgs)

## Declare ROS messages and services
##add_message_files(FILES Num.msg)
##add_service_files(FILES AddTwoInts.srv)

## Generate added messages and services
generate_messages(DEPENDENCIES std_msgs geometry_msgs sensor_msgs)

## Declare a catkin package
catkin_package()

## Build talker and listener
include_directories(include ${catkin_INCLUDE_DIRS})

add_executable(data_read src/data_acquire.cpp)
target_link_libraries(data_read ${catkin_LIBRARIES})
add_dependencies(data_read data_read_generate_messages_cpp)

add_executable(ground_station src/ground_station.cpp)
target_link_libraries(ground_station ${catkin_LIBRARIES})
add_dependencies(ground_station data_read_generate_messages_cpp)

# %EndTag(FULLTEXT)%
