#!/bin/bash
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Simulate continuous taxonomy

TARGETCATALOGTYPE=REGISTRY

$BASEDIR/addversiontoindex.sh "1.0.0" "" "" "BETA" "BETA" "$TARGETCATALOGTYPE" "TRUE"

$BASEDIR/addversiontoindex.sh "1.0.1" "1.0.0" "" "STABLE" "BETA,STABLE" "$TARGETCATALOGTYPE" "FALSE"
#$BASEDIR/addversiontoindex.sh "1.0.1" "1.0.0" "" "STABLE" "BETA,STABLE" "$TARGETCATALOGTYPE" "FALSE"  # workaround
# --channel--
# BETA|test-operator|testoperator.v1.0.1
# STABLE|test-operator|testoperator.v1.0.1
# --channel-entry--
# 1|BETA|test-operator|testoperator.v1.0.1|2|0
# 2|BETA|test-operator|testoperator.v1.0.0||1
# 3|STABLE|test-operator|testoperator.v1.0.1|4|0
# 4|STABLE|test-operator|testoperator.v1.0.0||1

$BASEDIR/addversiontoindex.sh "1.0.2" "1.0.1" "" "BETA" "BETA,STABLE" "$TARGETCATALOGTYPE" "FALSE"
# --channel--
# BETA|test-operator|testoperator.v1.0.2
# STABLE|test-operator|testoperator.v1.0.2 
# --channel-entry--
# 1|BETA|test-operator|testoperator.v1.0.1|2|1
# 2|BETA|test-operator|testoperator.v1.0.0||1
# 3|STABLE|test-operator|testoperator.v1.0.1|4|1
# 4|STABLE|test-operator|testoperator.v1.0.0||1
# 5|BETA|test-operator|testoperator.v1.0.2|1|0
# 6|STABLE|test-operator|testoperator.v1.0.2|3|0

$BASEDIR/addversiontoindex.sh "1.1.0" "" ">=1.0.2 <1.1.0" "BETA" "BETA" "$TARGETCATALOGTYPE"
#$BASEDIR/addversiontoindex.sh "1.1.0" "" ">=1.0.2 <1.1.0" "BETA" "BETA" "$TARGETCATALOGTYPE"
# --channel--
# STABLE|test-operator|testoperator.v1.0.2
# BETA|test-operator|testoperator.v1.1.0
# --channel-entry--
# 3|STABLE|test-operator|testoperator.v1.0.1|4|1
# 4|STABLE|test-operator|testoperator.v1.0.0||1
# 6|STABLE|test-operator|testoperator.v1.0.2|3|0
# 7|BETA|test-operator|testoperator.v1.1.0||0

$BASEDIR/addversiontoindex.sh "1.1.1" "" ">=1.0.2 <1.1.1" "BETA" "BETA" "$TARGETCATALOGTYPE"
#$BASEDIR/addversiontoindex.sh "1.1.1" "" ">=1.0.2 <1.1.1" "BETA" "BETA" "$TARGETCATALOGTYPE"
# --channel--
# STABLE|test-operator|testoperator.v1.0.2
# BETA|test-operator|testoperator.v1.1.1
# --channel-entry--
# 3|STABLE|test-operator|testoperator.v1.0.1|4|1
# 4|STABLE|test-operator|testoperator.v1.0.0||1
# 6|STABLE|test-operator|testoperator.v1.0.2|3|0
# 7|BETA|test-operator|testoperator.v1.1.1||0


$BASEDIR/addversiontoindex.sh "1.1.2" "" ">=1.0.2 <1.1.2" "STABLE" "BETA,STABLE" "$TARGETCATALOGTYPE"
#error loading bundle from image: Error adding package error loading bundle into db: testoperator.v1.1.2 specifies a replacement  that cannot be found"
#$BASEDIR/addversiontoindex.sh "1.1.2" "" ">=1.0.2 <1.1.2" "STABLE" "BETA,STABLE" "$TARGETCATALOGTYPE"
# --channel--
# BETA|test-operator|testoperator.v1.1.2  #SEEMS WRONG
# STABLE|test-operator|testoperator.v1.1.2
# --channel-entry--
# 1|BETA|test-operator|testoperator.v1.1.2||0
# 2|STABLE|test-operator|testoperator.v1.1.2||0
