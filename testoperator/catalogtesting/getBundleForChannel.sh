#!/bin/sh

PACKAGE=$1
CHANNEL=$2

DATA="{\"pkgName\": \"test-operator\", \"channelName\": \"$CHANNEL\"}"

grpcurl -plaintext -d "$DATA" localhost:50051 api.Registry.GetBundleForChannel
