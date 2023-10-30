#!/bin/bash
set -o errexit -o nounset -o pipefail

IMAGE_TAG=$(gcloud container images list-tags gcr.io/solcat-ayushmjain-dw-49/${1}/three-tier-app-fe --format="value(tags)" --limit=1)

FE_IMAGE="gcr.io/solcat-ayushmjain-dw-49/${1}/three-tier-app-fe:${IMAGE_TAG}"
API_IMAGE="gcr.io/solcat-ayushmjain-dw-49/${1}/three-tier-app-api:${IMAGE_TAG}"

cat <<EOT >> pre.env
cloud_run_api_cloud_run_service_image=${API_IMAGE}
cloud_run_fe_cloud_run_service_image=${FE_IMAGE}
EOT
echo "completed pre step"