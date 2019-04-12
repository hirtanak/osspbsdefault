#!/bin/bash
# Copyright Hiroshi Tanaka, hirtanak@gmail.com, @hirtanak . All rights reserved.
# Use of this source code is governed by MIT license that can be found in the LICENSE file.
set -ex

HOMEDIR=$(jetpack config cuser.home_dir)
SOFTWARE_VERSION=6
SOFTWARE_VERSION=$(jetpack config Software_version)
CUSER=${HOMEDIR##*/}
echo $CUSER
# License Port Setting
LICENSE=$(jetpack config LICENSE)
(echo "SOFTWARE_LICENSE_FILE=${LICENSE}"; echo "export PATH=$PATH:/mnt/exports/shared/home/azureuser/apps/${SOFTWARE_VERSION}/bin") > /etc/profile.d/software.sh
chmod a+x /etc/profile.d/software.sh

# make a /mnt/exports/apps directory. Azure VMs that have ephemeral storage 
# that mounted at /mnt/exports. If that does not exist this command will create it.
mkdir -p ${HOMEDIR}/apps
chmod -R a+rx ${HOMEDIR}/apps
chown -R ${CUSER}:${CUSER} ${HOMEDIR}/apps
echo $SOFTWARE_VERSION > ${HOMEDIR}/app/SOFTWARE_VERSION
mkdir -p ${HOMEDIR}/apps/sct${SOFTWARE_VERSION}
chmod -R a+rx ${HOMEDIR}/apps/sct${SOFTWARE_VERSION}
chown -R ${CUSER}:${CUSER} ${HOMEDIR}/apps/sct${SOFTWARE_VERSION}

# Create tempdir
tmpdir=$(mktemp -d)

# Sample Software Download
# Don't run if we've already expanded the Software tarball
# download OpenFOAM installer into tempdir and unpack it into the apps directory
pushd $tmpdir

#if [ ! -d ${HOMEDIR}/apps/{SOFTWARE_VERSION}]; then
#   jetpack download "${SOFTWARE_VERSION}.zip"
#   unzip ${SOFTWARE_VERSION}.zip -d ${HOMEDIR}/apps
#fi
#chmod -R a+rX ${HOMEDIR}/apps/${SOFTWARE_VERSION}
#chown -R ${CUSER}:${CUSER} ${HOMEDIR}/apps/${SOFTWARE_VERSION}

echo ${CYCLECLOUD_SPEC_PATH}
echo ${HOMEDIR}

# Download sample scripts
if [ ! -f ${HOMEDIR}/runpbs.sh ]; then
   cp ${CYCLECLOUD_SPEC_PATH}/files/runpbs.sh ${HOMEDIR}
fi
chmod a+rx ${HOMEDIR}/runpbs.sh
chown -R ${CUSER}:${CUSER} ${HOMEDIR}/runpbs.sh

if [ ! -f ${HOMEDIR}/script.sh ]; then
   cp ${CYCLECLOUD_SPEC_PATH}/files/script.sh ${HOMEDIR}
fi
chmod a+rx ${HOMEDIR}/script.sh
chown -R ${CUSER}:${CUSER} ${HOMEDIR}/script.sh

# set up dirctory and apps.
chmod -R a+rx ${HOMEDIR}/apps
chown -R ${CUSER}:${CUSER} ${HOMEDIR}/apps

if [ ! -f ${HOMEDIR}/l_mpi_p_5.1.3.223.tgz ]; then
   wget -nv https://hirostpublicshare.blob.core.windows.net/solvers/l_mpi_p_5.1.3.223.tgz -O ${HOMEDIR}/l_mpi_p_5.1.3.223.tgz
   chmod -R a+rx ${HOMEDIR}/l_mpi_p_5.1.3.223.tgz
   chown -R ${CUSER}:${CUSER} ${HOMEDIR}/l_mpi_p_5.1.3.223.tgz 
   tar zxf ${HOMEDIR}/l_mpi_p_5.1.3.223.tgz -C ${HOMEDIR}
   sed -i -e 's/ACCEPT_EULA=decline/ACCEPT_EULA=accept/' ${HOMEDIR}/l_mpi_p_5.1.3.223/silent.cfg
   sed -i -e 's/ACTIVATION_TYPE=exist_lic/ACTIVATION_TYPE=trial_lic/' ${HOMEDIR}/l_mpi_p_5.1.3.223/silent.cfg
   ${HOMEDIR}/l_mpi_p_5.1.3.223/install.sh -s silent.cfg
fi

yum install -y htop

#clean up
popd
rm -rf $tmpdir
