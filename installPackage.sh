mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make
tput setaf 2
echo "directory created"
tput sgr0
cd ~/catkin_ws/src
catkin_create_pkg robot_1 std_msgs rospy roscpp
cd ~/catkin_ws
catkin_make
echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc
...
cd 
sudo apt-get install ros-kinetic-joy
tput setaf2
echo "Joy node installation complete"
tput sgr0
ls -l /dev/input/js0
tput setaf 2
echo "port js0 set for input"
tput sgr0
sudo chmod a+rw /dev/input/js0
tput setaf 2
echo "read and write permission given"
tput sgr0


cd ~/catkin_ws/src
git clone https://github.com/ros-drivers/rosserial.git
cd ..
catkin_make
tput setaf 2
echo "rosserial installation complete"
tput sgr0

cd
sudo apt-get install ros-kinetic-multimaster-fkie
tput setaf 2
echo "multimaster fkie installation complete"
tput sgr0
