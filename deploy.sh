docker build -t skamer/multi-client:latest -t skamer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skamer/multi-server:latest -t skamer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t skamer/multi-worker:latest -t skamer/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push skamer/multi-client:latest
docker push skamer/multi-server:latest
docker push skamer/multi-worker:latest

docker push skamer/multi-client:$SHA
docker push skamer/multi-server:$SHA
docker push skamer/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=skamer/multi-server:$SHA
kubectl set image deployments/client-deployment client=skamer/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=skamer/multi-worker:$SHA
