
#include "ros/ros.h"
#include "std_msgs/String.h"
#include<geometry_msgs/Vector3.h>
#include<geometry_msgs/Vector3Stamped.h>
#include<geometry_msgs/Twist.h>
#include<sensor_msgs/Joy.h>

#include <sstream>
#include <iostream>
#include <fstream>




class TeleopJoy{
	public:
	 TeleopJoy();
	private:
	 void callBack(const sensor_msgs::Joy::ConstPtr& joy);
	 ros::NodeHandle n; 
	 ros::Publisher pub;
	 ros::Subscriber sub;
	// int i_velLinear, i_velAngular;
};
	TeleopJoy::TeleopJoy()
	 {
	  pub = n.advertise<geometry_msgs::Twist>("cmd_vel",1);
	  sub = n.subscribe<sensor_msgs::Joy>("joy", 10, &TeleopJoy::callBack,this);
	 }
	void TeleopJoy::callBack(const sensor_msgs::Joy::ConstPtr& joy)
	 {
	  geometry_msgs::Twist vel;
	  vel.linear.x = -(std::abs((joy->buttons[11]*300))+ joy->buttons[8]*300 ) ;//-(std::abs((joy->buttons[11]*400)) - ( - joy->buttons[9]*400));//-((joy->axes[1]*400)+(joy->axes[2]*400));
	  vel.angular.z = 0;//-(-(joy->axes[2]*400)+(joy->axes[1]*400));
	  pub.publish(vel);
 }

class readData{
	public: 
	 readData();
	private:
	 void callBack(const geometry_msgs::Twist::ConstPtr& msg);
	 ros::NodeHandle n;
	 ros::Subscriber sub;
         std::string filename = "/home/shravan/catkin_ws/src/data_read/matlab/robot3/data.csv";
};

	readData::readData(){
	sub = n.subscribe<geometry_msgs::Twist>("arduino_vel", 1000, &readData::callBack,this);
	}

	void readData::callBack(const geometry_msgs::Twist::ConstPtr& msg){
	 std::ofstream myfile;
         ROS_INFO("printing data");
	 myfile.open(filename.c_str(), std::ios::app);
         myfile << " W_left ";
         myfile << msg->linear.x;
         myfile << " W_right ";
         myfile << msg->linear.y;
         myfile << " sample_time ";
         myfile << msg->linear.z;
         myfile << " time ";
         myfile << msg->angular.x;
         myfile << " M2_current(left) ";
         myfile << msg->angular.y;
         myfile << " M1_current(right) ";
         myfile << msg->angular.z;
 	 myfile << "\n";
	 //myfile.close(); 
	 //return 0; 
}

int main(int argc, char **argv)
{
 ros::init(argc, argv, "ground_station");

 
 TeleopJoy teleop_turtle;
 readData dude;

 ros::spin();

 return 0;
}
