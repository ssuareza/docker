#!/bin/sh

INSTANCEID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/local-hostname)
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone |sed 's/[a-z]$//')
ENVIRONMENT=$(aws ec2 describe-tags --region us-east-1 --filters "Name=resource-id,Values=$INSTANCEID" "Name=key,Values=Env" --query Tags[].Value --output text)
CLUSTER=$(aws ec2 describe-tags --region $REGION --filters "Name=resource-id,Values=$INSTANCEID" "Name=key,Values=Name" --query Tags[].Value --output text |cut -f2 -d"." |sed s/"-standard"//g)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

while [ 1 ]; do
    CPU=$(kubectl describe node $HOSTNAME |grep -A 10 "Allocated resources"|grep cpu |awk '{print $3}'| tr -d '(,),%')
    MEM=$(kubectl describe node $HOSTNAME |grep -A 10 "Allocated resources"|grep memory |awk '{print $3}'| tr -d '(,),%')
    aws cloudwatch put-metric-data --region $REGION --metric-name CPUAllocation --namespace EKS --unit None --value ${CPU} --dimensions ClusterName=${CLUSTER},NodeName=shared
    aws cloudwatch put-metric-data --region $REGION --metric-name MemoryAllocation --namespace EKS --unit None --value ${MEM} --dimensions ClusterName=${CLUSTER},NodeName=shared
    echo "$TIMESTAMP Sending metric node $INSTANCEID values: cpu=$CPU, mem=$MEM"
    sleep 60
done
