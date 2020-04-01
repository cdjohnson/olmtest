# Operator Lifecycle Manager Testing Framework
This project includes a test framework that auto-generates Operator Bundles and Catalog Index Images based on various patterns.

## Prereqs
Linux:
* podman
* sqllite3 - to display the bundle database
* opm 
* operator-framework
* oc 4.3+

For Mac:
* docker instead of podman
* gsed

# addversiontoindex.sh
Builds an operator bundle using a CSV template located in `templates`.  Allows building arbitrary graphs of operators to demonstrate multi-channel graph toplogies, such as:  continuous, automatic z-build and hybrid.

## Usage
`addversiontoindex <version> <replacesversion> <skiprange> <defaultchannel> <channels> <targetcatalogtype> <newindex>`

Where:
- `version`:  The CSV `spec.version`
- `replacesversion`: The CSV `spec.replaces`
- `skiprange`: The `olm.skiprange` annotation
- `defaultchannel`: The default channel for the bundle
- `channels`: The channels for the bundle
- `targetrcatalogtype`: `REGISTRY` if using the `opm registry` comand, `IMAGE` if using the `opm image` command
- `newindex`:  If `TRUE`, delete the previous index and start from scratch.

# Samples
To build a Continuous graph using `replaces`:
1. `cd catalogtesting`
2. `./buildgraph_continuous_replaces.sh`