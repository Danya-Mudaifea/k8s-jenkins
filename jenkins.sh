#!/bin/bash
k3d cluster create jenkins -v /var/run/docker.sock:/var/run/docker.sock --agents 3 -p 30000-32767:30000-32767@server[0] -p 80:80@loadbalancer
kubectl apply -f jenkins.namespace.yaml -f jenkins.helm.yaml -f ingress.yaml
WAIT=90
echo "Sleeping for $WAIT"
sleep $WAIT
echo "Making progress"
. query.sh
kubectl create -n jenkins clusterrolebinding jenkins-account --clusterrole=cluster-admin --serviceaccount=jenkins:jenkins
