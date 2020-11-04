# setting up gcloud configuration for connecting corresponding GCP project & zone
prj-config:
	gcloud config set project wired-benefit-293406 && gcloud config set compute/zone compute-zone us-central1-c

# creting GKE cluster
create-cluster:
	gcloud container clusters create democluster

# verifying the rinning nodes
verify-cluster:
	gcloud compute instances list

# build docker image
build:
	docker build -t gcr.io/wired-benefit-293406/demoapp .

# build docker image
push:
	docker push gcr.io/wired-benefit-293406/demoapp

# deploying the app from docker regstry image
deploy:
	kubectl create deployment demoapp --image=gcr.io/wired-benefit-293406/demoapp:latest

# expose service and public end point & check the exposed service and get the public IP
expose:
	kubectl expose deployment demoapp --name=demoapp --type=LoadBalancer --port 80 --target-port 8080

# scalling configuration
scaleup:
	kubectl scale deployment demoapp --replicas=3

scaledown:
	kubectl scale deployment demoapp --replicas=1

# auto scalling configuration	
autoscale:	
	kubectl autoscale deployment demoapp --cpu-percent=80 --min=1 --max=5

update:
	kubectl set image deployment/demopapp demoapp=gcr.io/wired-benefit-293406/demoapp:v2

rollback:
	kubectl set image deployment/demopapp demoapp=gcr.io/wired-benefit-293406/demoapp

# checking the number of scalled pods
get-info:
	kubectl get pods,services,deployment,rc

# setting a new image for the app
refresh-image:
	kubectl set image deployment/demoapp demoapp=gcr.io/wired-benefit-293406/demoapp:latest

##### Clean Up #####

delete-deployment:
	kubectl delete deployment demoapp

# delete service
delete-service:
	kubectl delete service demoapp

# delete the cluster
delete-cluster:
	gcloud container clusters delete democluster --zone=us-central1-c

clean-docker:
	docker ps -a | grep "Exited " | awk '{print $1}' | xargs docker rm && docker ps -a | grep "Created " | awk '{print $1}' | xargs docker rm  && docker images -f dangling=true | grep "none" | awk '{print $3}'| xargs docker rmi


##	npm i -g express-generator && express --view=pug demoapp

##   alias k=kubectl && alias kgps="kubectl get pods,services"