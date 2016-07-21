#!/bin/bash

EMAIL=mjmata@hpe.com
LOG=cron.log
STATE=status
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR
export http_proxy="http://web-proxy.rose.hpecorp.net:8088"
export https_proxy="http://web-proxy.rose.hpecorp.net:8088"
export ftp_proxy="http://web-proxy.rose.hpecorp.net:8088"

/usr/sbin/logrotate -s logstatus logrotate.conf
echo "====================================================" >> $LOG
echo >> $LOG
date >> $LOG

function error() {
    cd ..
    echo $1 >> $LOG
    cat $STATE | read s
    if [ "$s" == "Pass" ]; then
        echo $1 | mail $EMAIL
    fi
    echo >> $LOG
    echo "Fail" > $STATE
    exit 1
}

cd hpe-topology-common
git pull 2>> ../$LOG
if [ $? -ne 0 ]; then
    error "NOSdoc: topology-common: Merge conflict"
fi
cd ..

cd hpe-topology-lib-communication
git pull 2>> ../$LOG
if [ $? -ne 0 ]; then
    error "NOSdoc: lib-communication: Merge conflict"
fi
cd ..

cd ops-topology-lib-vtysh
git pull 2>> ../$LOG
if [ $? -ne 0 ]; then
    error "NOSdoc: lib-vtysh: Merge conflict"
fi
cd ..

rm -rf hpe-topology-common/doc/topology_common
rm -rf hpe-topology-common/doc/topology_lib_communication
rm -rf hpe-topology-common/doc/topology_lib_vtysh
rm -rf hpe-topology-common/lib/topology_lib_communication/
rm -rf hpe-topology-common/lib/topology_lib_vtysh/
cp -a hpe-topology-lib-communication/lib/topology_lib_communication/ hpe-topology-common/lib
cp -a ops-topology-lib-vtysh/lib/topology_lib_vtysh/ hpe-topology-common/lib

cd hpe-topology-common

#pandoc doc/how_to_guide.md -o doc/how_to_guide.rst
#pandoc doc/writing_docstrings.md -o doc/writing_docstrings.rst
#pandoc doc/ops_tc_library_guidelines.md -o doc/ops_tc_library_guidelines.rst

/usr/local/bin/tox -e doc 2>> ../$LOG
if [ $? -ne 0 ]; then
    error "NOSdoc: Common: Sphinx build failed"
fi

cp doc/how_to_guide.md .tox/doc/tmp/html
cp doc/writing_docstrings.md .tox/doc/tmp/html
cp doc/ops_tc_library_guidelines.md .tox/doc/tmp/html
cp -a .tox/doc/tmp/html /var/www/
if [ $? -ne 0 ]; then
    error "NOSdoc: Could not update server"
fi

cd ..
echo "Documentation created" >> $LOG
echo >> $LOG
if [ "$s" == "Fail" ]; then
    echo "NOSdoc: API doc generation reestablished" | mail $EMAIL
fi
echo "Pass" > $STATE
exit 0
