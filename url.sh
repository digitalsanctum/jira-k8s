#!/bin/bash

set -e

export JIRA_NODE_PORT=$(kubectl get --namespace jira -o jsonpath="{.spec.ports[0].nodePort}" services jira-jira-software)
export JIRA_NODE_IP=$(kubectl get nodes --namespace jira -o jsonpath="{.items[0].status.addresses[0].address}")
echo http://$JIRA_NODE_IP:$JIRA_NODE_PORT
