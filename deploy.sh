docker build -t tomsou/multi-client:latest -t tomsou/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tomsou/multi-server:latest -t tomsou/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tomsou/multi-worker:latest -t tomsou/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tomsou//multi-client:latest
docker push tomsou//multi-server:latest
docker push tomsou//multi-worker:latest
docker push tomsou//multi-client:$SHA
docker push tomsou//multi-server:$SHA
docker push tomsou//multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tomsou/multi-server:$SHA
kubectl set image deployments/client-deployment client=tomsou/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tomsou/multi-worker:$SHA
