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
	  vel.linear.x = -((joy->axes[1]*400)+(joy->axes[2]*400));
	  vel.angular.z = -(-(joy->axes[2]*400)+(joy->axes[1]*400));
	  pub.publish(vel);
 }

class readData{
	public: 
	 readData();
	private:
	 void callBack(const geometry_msgs::Twist::ConstPtr& msg);
	 ros::NodeHandle n;
	 ros::Subscriber sub;
};

	readData::readData(){
	sub = n.subscribe<geometry_msgs::Twist>("arduino_vel", 10, &readData::callBack,this);
	}

	void readData::callBack(const geometry_msgs::Twist::ConstPtr& msg){
	 std::ofstream myfile;
	 myfile.open ("example.txt"); 
	 myfile << "this is the first cell in the first column.\n";
 	 myfile << "a,b,c,\n";
	 myfile << "c,s,v,\n";
	 myfile << "1,2,3.456\n";
	 myfile << "semi;colon";
	 myfile.close(); 
	 //return 0; 
}

int main(int argc, char **argv)
{
 ros::init(argc, argv, "data_read");

 TeleopJoy teleop_turtle;
 readData dude;

 ros::spin();

 return 0;
}
