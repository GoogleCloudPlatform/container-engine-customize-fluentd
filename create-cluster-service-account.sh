#!/bin/sh
# Copyright 2017 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
PROJECT=$(gcloud config get-value project)
ACCOUNT_NAME="cluster-service-account"

gcloud iam service-accounts create ${ACCOUNT_NAME} --display-name ${ACCOUNT_NAME}

gcloud projects add-iam-policy-binding $PROJECT \
  --member serviceAccount:${ACCOUNT_NAME}@${PROJECT}.iam.gserviceaccount.com \
  --role roles/logging.logWriter

gcloud projects add-iam-policy-binding $PROJECT \
  --member serviceAccount:${ACCOUNT_NAME}@${PROJECT}.iam.gserviceaccount.com \
  --role roles/monitoring.metricWriter
  
gcloud projects add-iam-policy-binding $PROJECT \
  --member serviceAccount:${ACCOUNT_NAME}@${PROJECT}.iam.gserviceaccount.com \
  --role roles/iam.serviceAccountActor 
  
gcloud projects add-iam-policy-binding $PROJECT \
  --member serviceAccount:${ACCOUNT_NAME}@${PROJECT}.iam.gserviceaccount.com \
  --role roles/container.admin 

gcloud iam service-accounts keys create \
  ${ACCOUNT_NAME}.json \
  --iam-account ${ACCOUNT_NAME}@${PROJECT}.iam.gserviceaccount.com
