#!/bin/bash
VPC_ID=$(aws ec2 describe-vpcs --endpoint-url=$AWS_ENDPOINT_URL --query 'Vpcs[0].VpcId' --output text)
IGW_ID=$(aws ec2 describe-internet-gateways --endpoint-url=$AWS_ENDPOINT_URL --query 'InternetGateways[0].InternetGatewayId' --output text)

aws ec2 detach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID --endpoint-url=$AWS_ENDPOINT_URL
aws ec2 delete-internet-gateway --internet-gateway-id $IGW_ID --endpoint-url=$AWS_ENDPOINT_URL
aws ec2 delete-vpc --vpc-id $VPC_ID --endpoint-url=$AWS_ENDPOINT_URL
echo "Cleaned up all resources."
