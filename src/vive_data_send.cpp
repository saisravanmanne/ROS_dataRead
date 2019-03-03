#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Int8.h"
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
	 void callBack(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr& msg);
	 geometry_msgs::Point tracker1;
};

	readData::readData(){
	sub = n.subscribe<geometry_msgs::PoseWithCovarianceStamped>("/vive/LHR_D254C151_pose", 1000, &readData::callBack,this);
	pub = n.advertise<geometry_msgs::Point>("tracker_1",1000);
	}

	void readData::callBack(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr& msg){
	 tf::Quaternion q(
        	msg->pose.pose.orientation.x,
        	msg->pose.pose.orientation.y,
        	msg->pose.pose.orientation.z,
        	msg->pose.pose.orientation.w);
	 tf::Matrix3x3 m(q);	
	 double roll, pitch, yaw;
     	 m.getRPY(roll, pitch, yaw); 
 	 tracker1.x = msg->pose.pose.position.x;
	 tracker1.y = -(msg->pose.pose.position.z);
	 tracker1.z = yaw;
	 pub.publish(tracker1);
}
	 //return 0; 


int main(int argc, char **argv)
{
 ros::init(argc, argv, "vive_data_send");

 //TeleopJoy teleop_turtle;
 readData dude;

 ros::spin();

 return 0;
}
