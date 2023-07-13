run:
	kubectl apply -f front-deployment.yaml
	kubectl apply -f api-deployment.yaml 
	kubectl apply -f db-deployment.yaml
	kubectl apply -f front-service.yaml
	kubectl apply -f api-service.yaml 
	kubectl apply -f db-service.yaml

fill-db:
	kubectl apply -f data-script-deployment.yaml

stop:
	kubectl delete deployment front
	kubectl delete deployment api
	kubectl delete deployment db
	kubectl delete service front
	kubectl delete service api
	kubectl delete service db

clean: stop
	kubectl delete pvc data-pvc