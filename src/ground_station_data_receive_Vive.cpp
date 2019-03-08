#include "ros/ros.h"
#include "ros/time.h"
#include "std_msgs/String.h"
#include "std_msgs/Int8.h"
#include "std_msgs/Float64.h"
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

double Radius = 0.06; // Change it (radius of wheel) 0.045
double Length = 0.36; // Change it (distance between 
int emergency = 0;

class emergencyStop{
        public:
	 emergencyStop();
	private:
	 ros::NodeHandle n;
	 ros::Subscriber sub;
	 void callBack(const sensor_msgs::Joy::ConstPtr& joy);
};
	emergencyStop::emergencyStop(){
	 sub = n.subscribe<sensor_msgs::Joy>("joy", 10, &emergencyStop::callBack,this);
	}
	
	void emergencyStop::callBack(const sensor_msgs::Joy::ConstPtr& joy){
	 if (joy->axes[1] + joy->axes[2] + joy->axes[3] != 0)
	  emergency = 1;
	}

class readData{
 	public: 
	 readData();   
	private:        // emergency stop feature programmed in the robot3 module incase of high current
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
         std::string filename = "/home/shravan/catkin_ws/src/data_read/matlab/robot3/data.csv";
};

	readData::readData(){
	sub = n.subscribe<geometry_msgs::Twist>("/cmd_vel2", 1000, &readData::callBack,this);
	sub2= n.subscribe<std_msgs::Float64>("input_voltage",1000, &readData::callBack2,this);
	pub = n.advertise<geometry_msgs::Twist>("cmd_vel",1000);		
	volt.data = 0;
	voltd.data = 0;
 	i = 0; 	
 	}

	void readData::callBack(const geometry_msgs::Twist::ConstPtr& msg){
	if (emergency == 1){
	 vel.linear.x = 0;
	 vel.angular.z = 0;	
         pub.publish(vel);
	}
	else{   
	if (volt.data - voltd.data != 0){
                vel.linear.x = -volt.data;
	        vel.angular.z = -volt.data;   
		pub.publish(vel);     	// when filtering is required due to encoder noise
		//if ((msg->linear.x != 0)&&(msg->linear.y != 0)){    // with Vive it may not be required
		  dataWrite(msg,volt);    
		  i = i+1;
            //	}
	        if (i == 350){
		  voltd.data = volt.data;
		  vel.linear.x = 0;
	          vel.angular.z = 0;	
                  pub.publish(vel);
		  i = 0;
		}
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
         myfile << " W_left " << (2*msg->linear.y + Length*msg->angular.y)/(2*Radius) << " W_right " << (2*msg->linear.y - Length*msg->angular.y)/(2*Radius) << " sample_time ";
         myfile << "100Hz" << " PWM_value "<< volt.data << "linear_velocity" << msg->linear.y;
	 myfile << "angular_velocity" << msg->angular.y << "\n";
	 myfile.close(); 
	 //return 0; 
}

int main(int argc, char **argv)
{
 ros::init(argc, argv, "ground_station_data_receive_Vive");
 
 emergencyStop delta;
 readData dude;
 
 ros::spin();

 return 0;
}
