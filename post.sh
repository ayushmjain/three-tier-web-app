#!/bin/bash
set -o errexit -o nounset -o pipefail

source post.env

STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" ${cloud_run_fe_service_endpoint})

if [ ${STATUS_CODE} != "200" ]; then
  echo "Three tier web app not ready, received status code: ${STATUS_CODE}"
  exit 1
fi

echo "completed post step"