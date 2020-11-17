docker build -t yatishnagaraj/multi-client:latest -t yatishnagaraj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yatishnagaraj/multi-server:latest -t yatishnagaraj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yatishnagaraj/multi-worker:latest -t yatishnagaraj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yatishnagaraj/multi-client:latest
docker push yatishnagaraj/multi-server:latest
docker push yatishnagaraj/multi-worker:latest

docker push yatishnagaraj/multi-client:$SHA
docker push yatishnagaraj/multi-server:$SHA
docker push yatishnagaraj/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=yatishnagaraj/multi-server:$SHA
kubectl set image deployments/client-deployment client=yatishnagaraj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yatishnagaraj/multi-worker:$SHA