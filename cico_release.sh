#!/bin/bash
# Show command before executing
set -x

# Exit on error
set -e

# This option sets the exit code of a pipeline to that of the rightmost command to exit with a
# non-zero status, or to zero if all commands of the pipeline exit successfully.
set -o pipefail

function release() {
    # add .npmrc file to give permissions
    echo '//registry.npmjs.org/:_authToken=${NPM_TOKEN}' > ~/.npmrc

    npm whoami

    # Enable verbose output
    npm config set loglevel verbose

    # Build and Release fabric8-analytics-lsp-server (It will update the tag on github and push fabric8-analytics-lsp-server to npmjs.org)
    npm run semantic-release

    publish_tar
}

function publish_tar() {
    # get the latest release id
    res=$(curl -s  https://api.github.com/repos/fabric8-analytics/fabric8-analytics-lsp-server/releases/latest | jq '. | { id: .id, upload_url: .upload_url }')

    release_id=$(echo $res | jq .id)
    upload_url=$(echo $res | jq .upload_url) 

    echo $release_id
    echo $upload_url

    npm_user=$(npm whoami)

    # upload the tar file to the latest release id
    filename="./ca-lsp-server.tar"
    asset_upload_url="https://uploads.github.com/repos/fabric8-analytics/fabric8-analytics-lsp-server/releases/$release_id/assets?name=$(basename $filename)"
    curl -X POST -H "Authorization: token $GH_TOKEN" -H "Content-Type: application/octet-stream" -u $npm_user:$GH_TOKEN --data-binary @"$filename" $asset_upload_url
}
