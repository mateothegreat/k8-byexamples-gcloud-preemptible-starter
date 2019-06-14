include .make/Makefile.inc


NS 				?= default
APP				?= gcloud-preemptible-starter-centos
IMAGE			?= google/cloud-sdk:183.0.0-alpine
PROJECT			?= streaming-platform-production
ZONE 			?= us-east1-b
INSTANCE_NAME	?= centos-1
KEY_PATH        ?= config/preemptible-restarter.json
## Use gcloud to start an instance (make run PROJECT=.. ZONE=..)
test: 

	@docker run -i 	-v $(PWD)/config:/config \
  					--rm 		\
  					$(IMAGE) 	\
					/bin/sh -c 'gcloud auth activate-service-account --key-file /config/service_account.json && gcloud compute instances start $(INSTANCE_NAME) --project $(PROJECT) --zone $(ZONE)'

install: secret-create

secret-create:

	kubectl create secret generic $(APP) --from-file=$(KEY_PATH)

secret-delete:

	kubectl delete secret $(APP)