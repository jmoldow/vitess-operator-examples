export PROJECT="YOUR-PROJECT-NAME" ; gcloud config set project $PROJECT

gcloud config unset compute/region ; gcloud config set compute/zone us-central1-c

export CLUSTER=my-first-cluster ; gcloud container clusters get-credentials $CLUSTER

AUTH_NETS=$(gcloud --format=json container clusters describe $CLUSTER | jq -r ".masterAuthorizedNetworksConfig.cidrBlocks[].cidrBlock" | xargs | sed -E "s/ /,/g")
MY_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
gcloud container clusters update $CLUSTER --enable-master-authorized-networks --master-authorized-networks "${MY_IP}/32,${AUTH_NETS}"

docker pull vitess/vtctlclient:v10.0.1

alias vtctlclient="docker run --network=host --expose=15999 vitess/vtctlclient:v10.0.1 /usr/bin/vtctlclient -server=host.docker.internal:15999"

kubectl apply -f operator.yaml
