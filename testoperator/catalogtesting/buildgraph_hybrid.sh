#!/bin/bash
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Simulate continuous taxonomy

TARGETCATALOGTYPE=REGISTRY

$BASEDIR/addversiontoindex.sh "1.0.0" "" "" "V1.0" "V1.0" "$TARGETCATALOGTYPE" "TRUE"
# --channel--
# V1.0|test-operator|testoperator.v1.0.0
# --channel-entry--
# 1|V1.0|test-operator|testoperator.v1.0.0||0

$BASEDIR/addversiontoindex.sh "1.0.1" "" "<1.0.1" "V1.0" "V1.0" "$TARGETCATALOGTYPE"
# --channel--
# V1.0|test-operator|testoperator.v1.0.1
# --channel-entry--
# 1|V1.0|test-operator|testoperator.v1.0.1||0

# BRIDGE TO 1.1
$BASEDIR/addversiontoindex.sh "1.0.2" "" "<1.0.2" "V1.1" "V1.0,V1.1" "$TARGETCATALOGTYPE"
# --channel--
# V1.0|test-operator|testoperator.v1.0.2
# V1.1|test-operator|testoperator.v1.0.2
# --channel-entry--
# 1|V1.0|test-operator|testoperator.v1.0.2||0
# 2|V1.1|test-operator|testoperator.v1.0.2||0

$BASEDIR/addversiontoindex.sh "1.1.0" "" ">=1.0.2 <1.1.0" "V1.1" "V1.1" "$TARGETCATALOGTYPE"
# --channel--
# V1.1|test-operator|testoperator.v1.1.0
# --channel-entry--
# 1|V1.0|test-operator|testoperator.v1.0.2||0
# 2|V1.1|test-operator|testoperator.v1.1.0||0

$BASEDIR/addversiontoindex.sh "1.1.1" "" ">=1.0.2 <1.1.1" "V1.1" "V1.1" "$TARGETCATALOGTYPE"

$BASEDIR/addversiontoindex.sh "1.0.3" "" ">=1.0.0 <1.0.3" "V1.0" "V1.0,V1.1" "$TARGETCATALOGTYPE"
