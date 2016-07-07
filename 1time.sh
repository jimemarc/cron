#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

git clone https://git-nos.rose.rdlabs.hpecorp.net/hpe/hpe-topology-common
git clone https://git-nos.rose.rdlabs.hpecorp.net/hpe/hpe-topology-lib-communication
git clone https://git.openswitch.net/openswitch/ops-topology-lib-vtysh

cp -v tox.ini hpe-topology-common/
cp -v conf.py hpe-topology-common/doc/
cp -v index.rst hpe-topology-common/doc/
cp -v module.rst hpe-topology-common/doc/_templates/autoapi/
cp -v custom.css hpe-topology-common/doc/_static/styles/
cp -v layout.html hpe-topology-common/doc/_templates/
cp -v ops-topology-lib-vtysh/doc/developer.rst hpe-topology-common/doc/

cd hpe-topology-common
git commit -am'msg'
cd ..
