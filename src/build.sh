tar czvfhL pcgr_predispose.tgz pcgr_predispose/
echo "Build the Docker Image"
TAG=`date "+%Y%m%d"`
docker build -t sigven/pcgr_predispose:$TAG --rm=true .
