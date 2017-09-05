
JOB_MANAGER_IP=`hostname -i`
FLINK_DOCKER_IMAGE=localhost:5000/flink
MESOS_MASTER_URL=zk://10.59.53.150:2181,10.59.55.24:2181,10.59.54.99:2181/mesos-20170609
MESOS_FRAMEWORK_NAME=flink-dev-02
MESOS_CONSTRAINS=layer:minerva

echo 'job manager ip: ' $JOB_MANAGER_IP

# config: https://ci.apache.org/projects/flink/flink-docs-release-1.3/setup/mesos.html

docker run -it --net=host --hostname $JOB_MANAGER_IP --rm \
        $FLINK_DOCKER_IMAGE /opt/flink/bin/mesos-appmaster.sh \
        -Dmesos.resourcemanager.tasks.container.type=docker \
        -Dmesos.resourcemanager.tasks.container.image.name=$FLINK_DOCKER_IMAGE \
        -Dmesos.resourcemanager.tasks.mem=8000 \
        -Dmesos.resourcemanager.tasks.cpus=1 \
        -Dmesos.resourcemanager.framework.name=$MESOS_FRAMEWORK_NAME \
        -Dmesos.resourcemanager.artifactserver.ssl.enabled=true \
        -Dmesos.resourcemanager.tasks.bootstrap-cmd='FLINK_HOME=/opt/flink' \
        -Dmesos.master=$MESOS_MASTER_URL \
        -Dmesos.constraints.hard.hostattribute=$MESOS_CONSTRAINS \
        -Dmesos.initial-tasks=5 \
        -Dmesos.maximum-failed-tasks=-1 \
        -Djobmanager.web.address=$JOB_MANAGER_IP \
	-Djobmanager.rpc.port=6123 \
        -Djobmanager.rpc.address=$JOB_MANAGER_IP \
        -Djobmanager.web.port=8081 \ 
	-Djobmanager.heap.mb=4048 \
        -Dtaskmanager.heap.mb=4048 \
        -Dtaskmanager.numberOfTaskSlots=2 \
        -Dtaskmanager.maxRegistrationDuration="10 min" \
        -Dparallelism.default=10

