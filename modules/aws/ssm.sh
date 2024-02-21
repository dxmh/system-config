#!/bin/bash
# Small shell script to assist in hopping into a shell on an EC2 instance

profile=${1:-"default"}
filter=${2:-""}

listInstances() {
  aws ec2 describe-instances --profile "$profile" | \
    jq -r '.Reservations[].Instances[] as $instance |
      $instance.Tags[] | select(.Key=="Name") as $name |
      $instance.InstanceId + "," + $name.Value + "," + $instance.State.Name + "," + $instance.LaunchTime'
}

selectInstance() {
  instance=$(listInstances | grep running | column -t -s"," | fzf -e -1 -q "$filter")
  instance_id=$(awk '{print $1}' <<< "$instance")
  instance_name=$(awk '{print $2}' <<< "$instance")
}

selectInstance

if [ -n "$instance_id" ]; then
  echo -e "Connecting to $instance_name ($instance_id) on $1..."
  sh -cx "aws ssm start-session --profile $1 --target $instance_id"
else
  echo No instance selected
fi
