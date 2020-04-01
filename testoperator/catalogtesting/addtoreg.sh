#!/bin/bash

TARGETREG="quay.io/cdjohnson"
VERSION=$1
VERSIONTAG="v$VERSION"
OLMCATALOGPATH="../deploy/olm-catalog"
PACKAGENAME="test-operator"
OPERATORNAME="testoperator"
# Commaseparated
CHANNELS="$2"
DEFAULTCHANNEL=$3


operator-sdk bundle create "$TARGETREG/$OPERATORNAME:$VERSIONTAG" --directory "$OLMCATALOGPATH/$PACKAGENAME/$VERSION" --package "$PACKAGENAME" --channels "$CHANNELS" --default-channel "$DEFAULTCHANNEL" -b docker 
docker push "$TARGETREG/$OPERATORNAME:$VERSIONTAG"
opm registry add -b "$TARGETREG/$OPERATORNAME:$VERSIONTAG" -c docker

