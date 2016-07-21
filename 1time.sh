#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

git clone https://git-nos.rose.rdlabs.hpecorp.net/hpe/hpe-topology-common
git clone https://git-nos.rose.rdlabs.hpecorp.net/hpe/hpe-topology-lib-communication
git clone https://git.openswitch.net/openswitch/ops-topology-lib-vtysh

cp -v conf.py hpe-topology-common/doc/
cp -v index.rst hpe-topology-common/doc/
cp -v how_to_guide.rst hpe-topology-common/doc/
cp -v writing_docstrings.rst hpe-topology-common/doc/
cp -v ops_tc_library_guidelines.rst hpe-topology-common/doc/
cp -v module.rst hpe-topology-common/doc/_templates/autoapi/
cp -v custom.css hpe-topology-common/doc/_static/styles/
cp -v collapse.js hpe-topology-common/doc/_static/
cp -v jquery-3.1.0.min.js hpe-topology-common/doc/_static/
cp -va jstree hpe-topology-common/doc/_static/
cp -v layout.html hpe-topology-common/doc/_templates/
cp -v ops-topology-lib-vtysh/doc/developer.rst hpe-topology-common/doc/
mkdir -pv hpe-topology-lib-communication/doc/_templates/autoapi/
cp -v module2.rst hpe-topology-lib-communication/doc/_templates/autoapi/
mkdir -pv ops-topology-lib-vtysh/doc/_templates/autoapi/
cp -v module2.rst ops-topology-lib-vtysh/doc/_templates/autoapi/

cd hpe-topology-common
git commit -am'msg'
cd ..
