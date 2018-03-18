include .make/Makefile.inc


NS 				?= default
APP				?= gcloud-preemptible-starter
IMAGE			?= google/cloud-sdk:183.0.0-alpine
PROJECT			?= streaming-platform-devqa
ZONE 			?= us-central1-a
INSTANCE_NAME	?= centos-1
KEY_PATH        ?= config/gcp-streaming-platform-devqa-e158812b35a9.json
## Use gcloud to start an instance (make run PROJECT=.. ZONE=..)
test: 

	@docker run -i 	-v $(PWD)/config:/config \
  					--rm 		\
  					$(IMAGE) 	\
					/bin/sh -c 'gcloud auth activate-service-account --key-file /config/service_account.json && gcloud compute instances start $(INSTANCE_NAME) --project $(PROJECT) --zone $(ZONE)'

install: secret/create

secret/create:

	kubectl create secret generic gcloud-service-account --from-file=$(KEY_PATH)