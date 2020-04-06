#!/bin/bash
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Simulate automatic z-build taxonomy

TARGETCATALOGTYPE=REGISTRY

$BASEDIR/addversiontoindex.sh "1.0.0" "" "" "V1.0" "V1.0" "$TARGETCATALOGTYPE" "TRUE"
# --channel--
# V1.0|test-operator|testoperator.v1.0.0
# --channel-entry--
# 1|V1.0|test-operator|testoperator.v1.0.0||0
# --operatorbundle--
# testoperator.v1.0.0|localhost:5000/cdjohnson/testoperator:v1.0.0

$BASEDIR/addversiontoindex.sh "1.0.1" "" "<1.0.1" "V1.0" "V1.0" "$TARGETCATALOGTYPE"
# --channel--
# V1.0|test-operator|testoperator.v1.0.1
# --channel-entry--
# 1|V1.0|test-operator|testoperator.v1.0.1||0
# --operatorbundle--
# testoperator.v1.0.0|localhost:5000/cdjohnson/testoperator:v1.0.0
# testoperator.v1.0.1|localhost:5000/cdjohnson/testoperator:v1.0.1

$BASEDIR/addversiontoindex.sh "1.0.2" "" "<1.0.2" "V1.0" "V1.0" "$TARGETCATALOGTYPE"
# --channel--
# V1.0|test-operator|testoperator.v1.0.2
# --channel-entry--
# 1|V1.0|test-operator|testoperator.v1.0.2||0
# --operatorbundle--
# testoperator.v1.0.0|localhost:5000/cdjohnson/testoperator:v1.0.0
# testoperator.v1.0.1|localhost:5000/cdjohnson/testoperator:v1.0.1
# testoperator.v1.0.2|localhost:5000/cdjohnson/testoperator:v1.0.2

$BASEDIR/addversiontoindex.sh "1.1.0" "" ">=1.0.2 <1.1.0" "V1.1" "V1.1" "$TARGETCATALOGTYPE"
# --channel--
# V1.1|test-operator|testoperator.v1.1.0
# --channel-entry--
# 1|V1.1|test-operator|testoperator.v1.1.0||0
# --operatorbundle--
# testoperator.v1.0.0|localhost:5000/cdjohnson/testoperator:v1.0.0
# testoperator.v1.0.1|localhost:5000/cdjohnson/testoperator:v1.0.1
# testoperator.v1.0.2|localhost:5000/cdjohnson/testoperator:v1.0.2
# testoperator.v1.1.0|localhost:5000/cdjohnson/testoperator:v1.1.0

$BASEDIR/addversiontoindex.sh "1.1.1" "" ">=1.0.2 <1.1.1" "V1.1" "V1.1" "$TARGETCATALOGTYPE"
# --channel--
# V1.1|test-operator|testoperator.v1.1.1
# --channel-entry--
# 1|V1.1|test-operator|testoperator.v1.1.1||0
# --operatorbundle--
# testoperator.v1.0.0|localhost:5000/cdjohnson/testoperator:v1.0.0
# testoperator.v1.0.1|localhost:5000/cdjohnson/testoperator:v1.0.1
# testoperator.v1.0.2|localhost:5000/cdjohnson/testoperator:v1.0.2
# testoperator.v1.1.0|localhost:5000/cdjohnson/testoperator:v1.1.0
# testoperator.v1.1.1|localhost:5000/cdjohnson/testoperator:v1.1.1

$BASEDIR/addversiontoindex.sh "1.0.3" "" ">=1.0.0 <1.0.3" "V1.0" "V1.0" "$TARGETCATALOGTYPE"
# --channel--
# V1.0|test-operator|testoperator.v1.0.3
# --channel-entry--
# 1|V1.0|test-operator|testoperator.v1.0.3||0
# --operatorbundle--
# testoperator.v1.0.0|localhost:5000/cdjohnson/testoperator:v1.0.0
# testoperator.v1.0.1|localhost:5000/cdjohnson/testoperator:v1.0.1
# testoperator.v1.0.2|localhost:5000/cdjohnson/testoperator:v1.0.2
# testoperator.v1.0.3|localhost:5000/cdjohnson/testoperator:v1.0.3
# testoperator.v1.1.0|localhost:5000/cdjohnson/testoperator:v1.1.0
# testoperator.v1.1.1|localhost:5000/cdjohnson/testoperator:v1.1.1