docker build -t cyanum/multi-client:latest -t cyanum/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cyanum/multi-server:latest -t cyanum/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cyanum/multi-worker:latest -t cyanum/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cyanum/multi-client:latest
docker push cyanum/multi-server:latest
docker push cyanum/multi-worker:latest

docker push cyanum/multi-client:$SHA
docker push cyanum/multi-server:$SHA
docker push cyanum/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cyanum/multi-server:$SHA
kubectl set image deployments/client-deployment client=cyanum/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cyanum/multi-worker:$SHA