#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

VERSION="$1"
REPLACESVERSION="$2"
SKIPRANGE="$3"
DEFAULTCHANNEL="$4"
CHANNELS="$5"
TARGETCATALOGTYPE="$6" #IMAGE | REGISTRY
NEWINDEX="$7"  #TRUE

CONTAINERCLI="podman"
SED="sed"
if [ $(uname) == "Darwin" ];
then
  CONTAINERCLI="docker"
  SED="gsed"
fi
#TARGETREG="quay.io/cdjohnson"
TARGETREG="localhost:5000/cdjohnson"
#TARGETREG="hyc-icpcontent-docker-local.artifactory.swg-devops.com/cdjohnson"
VERSIONTAG="v$VERSION"
#OLMCATALOGPATH="$BASEDIR/../deploy/olm-catalog"
OLMCATALOGPATH="$BASEDIR/temp/deploy/olm-catalog"
PACKAGENAME="test-operator"
OPERATORNAME="testoperator"
PACKAGEYAML="$BASEDIR/templates/$PACKAGENAME.package.yaml"

rm -rf "$OLMCATALOGPATH/$PACKAGENAME/$VERSION"
mkdir -p "$OLMCATALOGPATH/$PACKAGENAME/$VERSION"
CSVTEMPLATE="$BASEDIR/templates/$OPERATORNAME.vVERSION.clusterserviceversion.yaml"
CSV="$OLMCATALOGPATH/$PACKAGENAME/$VERSION/$OPERATORNAME.v$VERSION.clusterserviceversion.yaml"
cp $CSVTEMPLATE $CSV
if [ "$NEWINDEX" == "TRUE" ]; 
then
  cp $PACKAGEYAML $OLMCATALOGPATH
fi

eval "$SED -i \"s/%VERSION%/$VERSION/g\" $CSV"

if [ -z "$SKIPRANGE" ];
then
  eval "$SED -i \"s/%SKIPRANGELINE%//g\" $CSV"
else
  eval "$SED -i \"s/%SKIPRANGELINE%/olm.skiprange: \'$SKIPRANGE\'/g\" $CSV"
fi

if [ -z "$REPLACESVERSION" ];
then
  eval "$SED -i \"s/%REPLACESLINE%//g\" $CSV"
else
  eval "$SED -i \"s/%REPLACESLINE%/replaces: $OPERATORNAME.v$REPLACESVERSION/g\" $CSV"
fi

# OLD WAY
# Update the package.
# echo "- name: $DEFAULTCHANNEL" >> "$OLMCATALOGPATH/test-operator.package.yaml"
# echo "  currentCSV: testoperator.$VERSION" >> "$OLMCATALOGPATH/test-operator.package.yaml"
# gsed -i "s/defaultChannel: .*/defaultChannel: $DEFAULTCHANNEL/g" "$OLMCATALOGPATH/test-operator.package.yaml"

# NEW WAY
#operator-sdk bundle create -g --directory "$OLMCATALOGPATH/$OPERATORNAME/$VERSION" --package "$PACKAGENAME" --channels "$CHANNELS" --default-channel "$DEFAULTCHANNEL" 
operator-sdk bundle create "$TARGETREG/$OPERATORNAME:$VERSIONTAG" --directory "$OLMCATALOGPATH/$PACKAGENAME/$VERSION" --package "$PACKAGENAME" --channels "$CHANNELS" --default-channel "$DEFAULTCHANNEL"
eval "$CONTAINERCLI push $TARGETREG/$OPERATORNAME:$VERSIONTAG"
if [ "$TARGETCATALOGTYPE" == "IMAGE" ];
then
  if [ "$NEWINDEX" == "TRUE" ]; 
  then 
    opm index rm -o "$PACKAGENAME" -c "$CONTAINERCLI" --tag "$TARGETREG/testcatalog:latest" --from-index "$TARGETREG/testcatalog:latest" --debug
    opm index add -b "$TARGETREG/$OPERATORNAME:$VERSIONTAG" -c "$CONTAINERCLI" --tag "$TARGETREG/testcatalog:latest" --debug
  else
    opm index add -b "$TARGETREG/$OPERATORNAME:$VERSIONTAG" -c "$CONTAINERCLI" --tag "$TARGETREG/testcatalog:latest" --from-index "$TARGETREG/testcatalog:latest" --debug
  fi
  eval "$CONTAINERCLI push $TARGETREG/testcatalog:latest"
else
  if [ "$NEWINDEX" == "TRUE" ]; 
  then 
    rm bundles.db 
  fi
  opm registry add -b "$TARGETREG/$OPERATORNAME:$VERSIONTAG" -c "$CONTAINERCLI" --debug
  echo "--channel--"
  sqlite3 bundles.db "select * from channel"
  echo "--channel-entry--"
  sqlite3 bundles.db "select * from channel_entry"
  echo "--operatorbundle--"
  sqlite3 bundles.db "select name,bundlepath from operatorbundle;"
fi
