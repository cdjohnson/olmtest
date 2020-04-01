#!/bin/bash
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Simulate continuous taxonomy

TARGETCATALOGTYPE=REGISTRY

$BASEDIR/addversiontoindex.sh "1.0.0" "" "" "BETA" "BETA" "$TARGETCATALOGTYPE" "TRUE"
$BASEDIR/addversiontoindex.sh "1.0.1" "1.0.0" "" "BETA" "BETA" "$TARGETCATALOGTYPE"
$BASEDIR/addversiontoindex.sh "1.0.2" "1.0.1" "" "BETA" "BETA" "$TARGETCATALOGTYPE"
$BASEDIR/addversiontoindex.sh "1.1.0" "1.0.2" "" "BETA" "BETA" "$TARGETCATALOGTYPE"
# --channel--
# BETA|test-operator|testoperator.v1.1.0
# --channel-entry--
# 1|BETA|test-operator|testoperator.v1.0.0||1
# 2|BETA|test-operator|testoperator.v1.0.1|1|1
# 3|BETA|test-operator|testoperator.v1.0.2|2|1
# 4|BETA|test-operator|testoperator.v1.1.0|3|0