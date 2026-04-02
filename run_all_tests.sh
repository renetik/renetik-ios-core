#!/bin/zsh

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)
PROJECT_DIR="$SCRIPT_DIR/Renetik/Example"
WORKSPACE="$PROJECT_DIR/Renetik.xcworkspace"
SCHEME="Renetik-Example"
HELPERS="$SCRIPT_DIR/test_helpers.sh"
PODS_XCCONFIG="$PROJECT_DIR/Pods/Target Support Files/Pods-Renetik_Example/Pods-Renetik_Example.debug.xcconfig"
DERIVED_DATA_PATH="/tmp/renetik-ios-tests-derived"

if [[ ! -f "$HELPERS" ]]; then
    echo "Missing shared test helpers: $HELPERS" >&2
    exit 1
fi

source "$HELPERS"

DESTINATION_VALUE=$(resolve_destination "$WORKSPACE" "$SCHEME")
ensure_pods_installed "$PROJECT_DIR" "$PODS_XCCONFIG" "Renetik Example"

echo "Running Renetik tests"
echo "Workspace: $WORKSPACE"
echo "Scheme: $SCHEME"
echo "Destination: $DESTINATION_VALUE"
echo "DerivedData: $DERIVED_DATA_PATH"

xcodebuild test \
    -workspace "$WORKSPACE" \
    -scheme "$SCHEME" \
    -destination "$DESTINATION_VALUE" \
    -derivedDataPath "$DERIVED_DATA_PATH"
