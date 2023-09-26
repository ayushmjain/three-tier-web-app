#curl \
#    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
#    -H "Content-Type: application/json" \
#    "https://config.googleapis.com/v1/projects/solcat-ayushmjain-dw-50/locations/us-central1/deployments"

#DEPLOYMENT_ID=three-tier-app-deployment
#curl \
#    -X POST \
#    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
#    -H "Content-Type: application/json" \
#    "https://config.googleapis.com/v1/projects/solcat-ayushmjain-dw-50/locations/us-central1/deployments/?deployment_id=${DEPLOYMENT_ID}" \
#    --data '{
#      "serviceAccount": "projects/solcat-ayushmjain-dw-50/serviceAccounts/im-test@solcat-ayushmjain-dw-50.iam.gserviceaccount.com",
#      "terraformBlueprint": {
#        "gitSource": {
#         "repo": "https://github.com/ayushmjain/three-tier-web-app.git",
#        },
#        "inputValues": {
#         "project": {
#          "inputValue": "solcat-ayushmjain-dw-50",
#         },
#         "region": {
#          "inputValue": "us-central1",
#         },
#         "zone": {
#          "inputValue": "us-central1-a",
#         },
#         "network_compute_network_name": {
#          "inputValue": "three-tier-app",
#         },
#         "sql-database_database_name": {
#          "inputValue": "three-tier-app",
#         },
#         "redis_redis_name": {
#          "inputValue": "three-tier-app",
#         },
#         "cloud-run-api_cloud_run_sa_id": {
#          "inputValue": "three-tier-app-api",
#         },
#         "cloud-run-api_cloud_run_service_image": {
#          "inputValue": "gcr.io/sic-container-repo/todo-api-postgres:latest",
#         },
#         "cloud-run-api_cloud_run_service_name": {
#          "inputValue": "three-tier-app-api",
#         },
#         "cloud-run-api_vpc_access_egress": {
#          "inputValue": "all",
#         },
#         "cloud-run-fe_cloud_run_sa_id": {
#          "inputValue": "three-tier-app-fe",
#         },
#         "cloud-run-fe_cloud_run_service_image": {
#          "inputValue": "gcr.io/sic-container-repo/todo-fe",
#         },
#         "cloud-run-fe_cloud_run_service_name": {
#          "inputValue": "three-tier-app-fe",
#         },
#        },
#      },
#    }'

#DEPLOYMENT_ID=three-tier-app-deployment
#curl \
#    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
#    -H "Content-Type: application/json" \
#    "https://config.googleapis.com/v1/projects/solcat-ayushmjain-dw-50/locations/us-central1/deployments/${DEPLOYMENT_ID}/revisions/r-0"

DEPLOYMENT_ID=three-tier-app
curl \
    -X DELETE \
    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    -H "Content-Type: application/json" \
    "https://config.googleapis.com/v1/projects/solcat-ayushmjain-dw-49/locations/us-central1/deployments/${DEPLOYMENT_ID}?force=true"