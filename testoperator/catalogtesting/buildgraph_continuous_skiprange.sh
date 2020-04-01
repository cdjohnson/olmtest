#!/bin/bash
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Simulate continuous taxonomy

TARGETCATALOGTYPE=REGISTRY

$BASEDIR/addversiontoindex.sh "1.0.0" "" "" "BETA" "BETA" "$TARGETCATALOGTYPE" "TRUE"
# --channel--
# BETA|test-operator|testoperator.v1.0.0
# --channel-entry--
# 1|BETA|test-operator|testoperator.v1.0.0||0

$BASEDIR/addversiontoindex.sh "1.0.1" "" "<1.0.1" "BETA" "BETA" "$TARGETCATALOGTYPE"
$BASEDIR/addversiontoindex.sh "1.0.2" "" "<1.0.2" "BETA" "BETA" "$TARGETCATALOGTYPE"
$BASEDIR/addversiontoindex.sh "1.1.0" "" "<1.0.3" "BETA" "BETA" "$TARGETCATALOGTYPE"