ensure_pods_installed() {
    local project_dir="$1"
    local pods_xcconfig="$2"
    local project_name="$3"

    if [[ -f "$pods_xcconfig" ]]; then return; fi
    if ! command -v pod >/dev/null 2>&1; then
        echo "CocoaPods is required but 'pod' was not found in PATH." >&2
        exit 1
    fi

    echo "CocoaPods support files missing for $project_name. Running pod install..."
    (
        cd "$project_dir"
        pod install
    )
}

resolve_destination() {
    local workspace="$1"
    local scheme="$2"

    if [[ -n "${DESTINATION:-}" ]]; then
        print -r -- "$DESTINATION"
        return
    fi

    local destinations simulator_id
    destinations=$(xcodebuild -showdestinations -workspace "$workspace" -scheme "$scheme")
    simulator_id=$(print -r -- "$destinations" | awk '
        /platform:iOS Simulator/ && $0 !~ /placeholder/ {
            if (match($0, /id:[^, ]+/)) {
                print substr($0, RSTART + 3, RLENGTH - 3)
                exit
            }
        }
    ')

    if [[ -z "$simulator_id" ]]; then
        echo "No concrete iOS Simulator destination found for $scheme." >&2
        echo "Set DESTINATION='platform=iOS Simulator,id=<simulator-id>' and rerun." >&2
        exit 1
    fi

    print -r -- "platform=iOS Simulator,id=$simulator_id"
}
