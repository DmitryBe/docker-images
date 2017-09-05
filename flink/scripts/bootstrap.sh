
echo 'bootstrapping...'

export FLINK_HOME=/opt/flink
export FLINK=/opt/flink

echo 'tail -f /etc/hosts' >> $FLINK_HOME/bin/mesos-taskmanager.sh
