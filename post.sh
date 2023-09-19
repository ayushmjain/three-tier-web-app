#!/bin/bash
set -o errexit -o nounset -o pipefail

source post.env
echo "${cloud-run-fe_service_endpoint}"
echo "completed post step"