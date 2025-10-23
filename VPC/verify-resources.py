import boto3, os

endpoint = os.getenv("AWS_ENDPOINT_URL", "http://localhost:4566")
ec2 = boto3.client("ec2", endpoint_url=endpoint)

print("=== VPCs ===")
for vpc in ec2.describe_vpcs()["Vpcs"]:
    print(vpc["VpcId"], vpc["CidrBlock"])

print("\n=== Subnets ===")
for sn in ec2.describe_subnets()["Subnets"]:
    print(sn["SubnetId"], sn["CidrBlock"])

print("\n=== Route Tables ===")
for rt in ec2.describe_route_tables()["RouteTables"]:
    print(rt["RouteTableId"])
