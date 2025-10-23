#!/bin/bash
# Create VPC
VPC_ID=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --endpoint-url=$AWS_ENDPOINT_URL --query 'Vpc.VpcId' --output text)
echo "Created VPC: $VPC_ID"

# Create Subnet
SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24 --endpoint-url=$AWS_ENDPOINT_URL --query 'Subnet.SubnetId' --output text)
echo "Created Subnet: $SUBNET_ID"

# Create Internet Gateway
IGW_ID=$(aws ec2 create-internet-gateway --endpoint-url=$AWS_ENDPOINT_URL --query 'InternetGateway.InternetGatewayId' --output text)
aws ec2 attach-internet-gateway --vpc-id $VPC_ID --internet-gateway-id $IGW_ID --endpoint-url=$AWS_ENDPOINT_URL
echo "Created and attached Internet Gateway: $IGW_ID"

# Create Route Table
RT_ID=$(aws ec2 create-route-table --vpc-id $VPC_ID --endpoint-url=$AWS_ENDPOINT_URL --query 'RouteTable.RouteTableId' --output text)
aws ec2 create-route --route-table-id $RT_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID --endpoint-url=$AWS_ENDPOINT_URL
aws ec2 associate-route-table --route-table-id $RT_ID --subnet-id $SUBNET_ID --endpoint-url=$AWS_ENDPOINT_URL
echo "Created Route Table: $RT_ID"
