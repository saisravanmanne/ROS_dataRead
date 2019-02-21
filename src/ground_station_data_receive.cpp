#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Float64.h"
#include<geometry_msgs/Vector3.h>
#include<geometry_msgs/Vector3Stamped.h>
#include<geometry_msgs/Twist.h>
#include<sensor_msgs/Joy.h>

#include <sstream>
#include <iostream>
#include <fstream>

class readData{
	public: 
	 readData();
	private:
	 void callBack(const geometry_msgs::Twist::ConstPtr& msg);
	 void callBack2(const std_msgs::Float64::ConstPtr& v);
         void dataWrite(const geometry_msgs::Twist::ConstPtr& msg,std_msgs::Float64 v);
	 geometry_msgs::Twist vel;
         std_msgs::Float64 volt;
	 std_msgs::Float64 voltd;
	 int i;
  	 ros::NodeHandle n;
	 ros::Subscriber sub; 
	 ros::Subscriber sub2;
         ros::Publisher pub;
         std::string filename = "/home/shravan/catkin_ws/src/data_read/matlab/data.csv";
};

	readData::readData(){
	sub = n.subscribe<geometry_msgs::Twist>("arduino_vel", 1000, &readData::callBack,this);
	sub2= n.subscribe<std_msgs::Float64>("input_voltage",1000, &readData::callBack2,this);
	pub = n.advertise<geometry_msgs::Twist>("cmd_vel",1);		
	volt.data = 0;
	voltd.data = 0;
 	i = 0; 	
 	}

	void readData::callBack(const geometry_msgs::Twist::ConstPtr& msg){
        if (volt.data - voltd.data != 0){
                vel.linear.x = volt.data;
	        vel.angular.z = volt.data;        	
		if ((msg->angular.y > 0)&&(msg->angular.z > 0)){
		  dataWrite(msg,volt);
		  i = i+1;
            	}
	        if (i == 2000){
		  voltd.data = volt.data;
		  vel.linear.x = 0;
	          vel.angular.z = 0;	
                  pub.publish(vel);
		  i = 0;
		}
     	 }
 	
	 }	 
         
         void readData::callBack2(const std_msgs::Float64::ConstPtr& v){
         volt.data = v->data;	
         }
	 
	 void readData::dataWrite(const geometry_msgs::Twist::ConstPtr& msg, std_msgs::Float64 v){
 	 std::ofstream myfile;
         ROS_INFO("printing data");
	 myfile.open(filename.c_str(), std::ios::app);
         myfile << " W_left " << msg->linear.x << " W_right " << msg->linear.y << " sample_time ";
         myfile << msg->linear.z << " time "<< msg->angular.x << " M2_analog(left) " << msg->angular.y;
         myfile << " M1_analog(right) " << msg->angular.z << " PWM value " << v.data << "\n";
	 myfile.close(); 
	 //return 0; 
}

int main(int argc, char **argv)
{
 ros::init(argc, argv, "data_receive");

 readData dude;

 ros::spin();

 return 0;
}
