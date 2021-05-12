# Instructions

```
# Install Operator
kubectl apply -f operator.yaml

# Bring up initial cluster and commerce keyspace
kubectl apply -f 101_initial_cluster.yaml
vtctlclient ApplySchema -sql="$(cat create_commerce_schema.sql)" commerce
vtctlclient ApplyVSchema -vschema="$(cat vschema_commerce_initial.json)" commerce

# Insert and verify data
mysql < ../common/insert_commerce_data.sql
mysql --table < ../common/select_commerce_data.sql

# Down cluster
kubectl delete -f 101_initial_cluster.yaml
```
