# gke-skaffold-demo

This is a starter application to demonstrate how easily we can build stater Microservice app, build container image , push it to GCR and deploy the same as Kubernetes POD to GKE.

Below are useful commands that can be used during the demo

> Export the GCP project id first

```
    export PROJECT_ID=<your GCP project id>
```

> Create the starter nodejs app

```
	npm i -g express-generator

	express --view=pug demoapp
```
> Build the Docker image
```
    docker build -t gcr.io/${PROJECT_ID}/demoapp .
```

> Push the Docker image to GCR 

```
	docker push gcr.io/${PROJECT_ID}/demoapp
```

> Deploy the app to GKE

```
	kubectl create deployment demoapp --image=gcr.io/${PROJECT_ID}/demoapp:latest
```
> Expose the app as LoadBalancer Service 
```
	kubectl expose deployment demoapp --name=demoapp --type=LoadBalancer --port 80 --target-port 8080
```
> Scale up the K8 pod
```
	kubectl scale deployment demoapp --replicas=3
```
> Scale down the K8 pod
```
	kubectl scale deployment demoapp --replicas=3
```
> Create HPA - Autoscale configuration
```
	kubectl autoscale deployment demoapp --cpu-percent=80 --min=1 --max=5
```
> Update the pod image to next version
```
	kubectl set image deployment/demopapp demoapp=gcr.io/${PROJECT_ID}/demoapp:v2
```
> Update the pod image to previous version
```	
    kubectl set image deployment/demopapp demoapp=gcr.io/${PROJECT_ID}/demoapp
```
> Get K8 cluster info
```
    kubectl get pods,services,deployment,rc
```
> Clean up
```
	kubectl delete deployment demoapp

	kubectl delete service demoapp
```
> Init Skaffold	
```
    skaffold init
```

> Run Skaffold	in DEV mode
```
    skaffold dev
```
> Run Skaffold in Production mode	
```
    skaffold run
```

