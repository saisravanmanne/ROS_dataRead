#include "ros/ros.h"
#include "ros/time.h"
#include "std_msgs/String.h"
#include "std_msgs/Int8.h"
#include <cmath>
#include <tf/tf.h>
#include<geometry_msgs/Vector3.h>
#include<geometry_msgs/Vector3Stamped.h>
#include<geometry_msgs/Twist.h>
#include<geometry_msgs/Point.h>
#include<geometry_msgs/PoseWithCovarianceStamped.h>
#include<sensor_msgs/Joy.h>
#include <sstream>
#include <iostream>
#include <fstream>

class readData{
	public: 
	 readData();
	private:
	 ros::NodeHandle n;
	 ros::Publisher pub;
	 ros::Subscriber sub;
	 ros::Subscriber sub2;
	 void callBack(const geometry_msgs::Point::ConstPtr& msg);
	 void callBack2(const sensor_msgs::Joy::ConstPtr& msg);
	 geometry_msgs::Twist vel;
	 geometry_msgs::Point pre_msg;
	 double time;
	 double pre_time2;
	 double pre_time;
};

readData::readData(){
	sub = n.subscribe<geometry_msgs::Point>("/tracker_2", 1000, &readData::callBack,this);
	pub = n.advertise<geometry_msgs::Twist>("cmd_vel",1000);
	sub2 = n.subscribe<sensor_msgs::Joy>("/joy", 1000, &readData::callBack2,this);
		
	}

void readData::callBack(const geometry_msgs::Point::ConstPtr& msg){
	if ((std::abs(msg->x - pre_msg.x) > 0.008) || (std::abs(msg->y - pre_msg.y) > 0.008)) {
		time = ros::Time::now().toSec();		
		vel.linear.y = sqrt(pow(((msg->x - pre_msg.x)/(time - pre_time)),2) + pow(((msg->y - pre_msg.y)/(time - pre_time)),2));
		pre_msg.x = msg->x;
		pre_msg.y = msg->y;
		pre_time = time;
		pub.publish(vel);	
	}
	if (std::abs(msg->z - pre_msg.z) > 0.005) {
  		time = ros::Time::now().toSec();
		vel.angular.y = (msg->z - pre_msg.z)/(time - pre_time2);
		vel.angular.z = msg->z;
		pre_msg.z = msg->z;
		pre_time2 = time;
		pub.publish(vel);	
	}
	else {	
		vel.linear.y = 0;
		vel.angular.y = 0;
		pub.publish(vel);	
	}
}

void readData::callBack2(const sensor_msgs::Joy::ConstPtr& msg){
	vel.linear.x = std::abs((msg->axes[1]*2));
	vel.angular.x = (msg->axes[2]*2);
	pub.publish(vel);	
}

int main(int argc, char **argv)
{
 ros::init(argc, argv, "ground_station_innerLoop");

 //TeleopJoy teleop_turtle;
 readData dude;

 ros::spin();

 return 0;
}






