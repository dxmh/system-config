#!/bin/bash
# Small shell script to assist in hopping into a shell on an ECS instance

profile=${1:-"default"}
filter=${2:-""}

listContainers() {
  for cluster in $(aws --profile $profile ecs list-clusters --query clusterArns --output text | grep -Eo '[0-9a-z-]+$'); do
    for task in $(aws --profile $profile ecs list-tasks --cluster $cluster --query taskArns --output text | grep -Eo '[0-9a-f]+$'); do
      for container in $(aws --profile $profile ecs describe-tasks --tasks $task --cluster $cluster --query 'tasks[].containers[].name' --output text); do
        echo $cluster $task $container
      done
    done
  done
}

selectContainer() {
  selection=$(listContainers | fzf -e -1 -q "$filter")
  cluster=$(awk '{print $1}' <<< "$selection")
  task=$(awk '{print $2}' <<< "$selection")
  container=$(awk '{print $3}' <<< "$selection")
}

selectContainer

if [ -n "$selection" ]; then
  echo -e "Connecting to $container on $cluster (task $task)..."
  sh -cx "aws --profile $profile ecs execute-command --cluster $cluster --task $task --container $container --interactive --command /bin/bash"
else
  echo No container selected
fi
