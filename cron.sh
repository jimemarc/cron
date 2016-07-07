#!/bin/bash

EMAIL=mjmata@hpe.com
LOG=cron.log
STATE=status
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR
date >> $LOG

function error {
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
    error "topology-common: Merge conflict"
fi
cd ..

cd hpe-topology-lib-communication
git pull 2>> ../$LOG
if [ $? -ne 0 ]; then
    error "lib-communication: Merge conflict"
fi
cd ..

cd ops-topology-lib-vtysh
git pull 2>> ../$LOG
if [ $? -ne 0 ]; then
    error "lib-vtysh: Merge conflict"
fi
cd ..

cp -a hpe-topology-lib-communication/lib/topology_lib_communication/ hpe-topology-common/lib
cp -a ops-topology-lib-vtysh/lib/topology_lib_vtysh/ hpe-topology-common/lib

cd hpe-topology-common

pandoc doc/how_to_guide.md -o doc/how_to_guide.rst
pandoc doc/writing_docstrings.md -o doc/writing_docstrings.rst
pandoc doc/ops_tc_library_guidelines.md -o doc/ops_tc_library_guidelines.rst

tox -e doc 2>> ../$LOG
if [ $? -ne 0 ]; then
    error "Sphinx build failed"
fi

cp doc/how_to_guide.md .tox/doc/tmp/html
cp doc/writing_docstrings.md .tox/doc/tmp/html
cp doc/ops_tc_library_guidelines.md .tox/doc/tmp/html
# cp -a .tox/doc/tmp/html /var/www

cd ..
echo "Documentation created" >> $LOG
echo >> $LOG
echo "Pass" > $STATE
exit 0
