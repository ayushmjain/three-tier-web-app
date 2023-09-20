#!/bin/bash
set -o errexit -o nounset -o pipefail
cat <<EOT >> pre.env
cloud_run_api_cloud_run_service_image="gcr.io/sic-container-repo/todo-api-postgres:latest"
cloud_run_fe_cloud_run_service_image="gcr.io/sic-container-repo/todo-fe"
EOT
echo "completed pre step"