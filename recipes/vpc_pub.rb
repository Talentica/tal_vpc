#
#Chef: Cookbook : tal_vpc
#Recipe : vpc_pub
#

require 'chef/provisioning/aws_driver'

aws = JSON.parse(File.read("/home/shantanup/Documents/Devop_Project/aws_vpc/docs/vpc.json"))

with_driver "aws::#{aws['region']}"

aws_vpc "#{aws['vpc']['vpcid']}" do
  cidr_block "#{aws['vpc']['cidr']}"
  internet_gateway true
  main_routes '0.0.0.0/0' => :internet_gateway
end

aws["publicsubnet"].each do |subnet|  
  puts("Inside the loop")
  aws_subnet "#{subnet['name']}" do
   vpc "#{aws['vpc']['vpcid']}"
   cidr_block "#{subnet['cidr']}"
   availability_zone "#{subnet['az']}"
   map_public_ip_on_launch true
  end
end

