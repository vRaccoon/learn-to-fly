#!/bin/sh


## Copy the deployment File from the mounted git ressource (r-git-raccoon/<path-2-file-within-git-repo>)
## to the output directory, which will be mounted as input later
cp r-git/k8s/deployment.yml e-modified-deployment/deployment.yml

### Get latest digest
#!/bin/bash

curl -k --silent \
 -X GET "https://tanzu-harbor.vraccoon.lab/api/v2.0/projects/library/repositories/learn-to-fly/artifacts?page=1&page_size=10&with_tag=true&with_label=false&with_scan_overview=false&with_signature=false&with_immutable_status=false" \
 -H "accept: application/json" \
 -H 'authorization: Basic YWRtaW46UGFzc3dvcmQxMjMhCg==' \
 -o harbor-output.json

## Get latest Digest
digest=$(jq '.[0].digest' harbor-output.json -r)


## Modify the image key within the deployment file
sed -i "s/IMAGE/$digest/g" e-modified-deployment/deployment.yml

