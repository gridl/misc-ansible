export MASTER_IP=${1}

set -e

docker run -d --net=host jasonbrooks/kubernetes-apiserver:centos --admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ResourceQuota --address=0.0.0.0 --insecure-bind-address=0.0.0.0

docker run -d --net=host --privileged jasonbrooks/kubernetes-controller-manager:centos

docker run -d --net=host jasonbrooks/kubernetes-scheduler:centos

atomic run --opt3="--master=http://$MASTER_IP:8080" jasonbrooks/kubernetes-proxy:centos
