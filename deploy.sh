docker build -t valegio/multi-client:latest -t valegio/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t valegio/multi-server:latest -t valegio/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t valegio/multi-worker:latest -t valegio/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push valegio/multi-client:latest
docker push valegio/multi-server:latest
docker push valegio/multi-worker:latest

docker push valegio/multi-client:$SHA
docker push valegio/multi-server:$SHA
docker push valegio/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=valegio/multi-server:$SHA
kubectl set image deployments/client-deployment client=valegio/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=valegio/multi-worker:$SHA