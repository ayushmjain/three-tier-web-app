#!/bin/bash
set -o errexit -o nounset -o pipefail

source post.env
echo "${cloud_run_fe_service_endpoint}"
echo "completed post step"