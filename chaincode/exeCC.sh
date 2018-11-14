#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error
set -e

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1
starttime=$(date +%s)
LANGUAGE=${1:-"golang"}
CC_SRC_PATH=github.com/user/go
if [ "$LANGUAGE" = "node" -o "$LANGUAGE" = "NODE" ]; then
	CC_SRC_PATH=/opt/gopath/src/github.com/user/node
fi

# clean the keystore
rm -rf ./hfc-key-store

# launch network; create channel and join peer to channel
cd ../network



docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/ssuet.example.com/users/Admin@ssuet.example.com/msp" cli peer chaincode install -n mycc -v 1.3 -p "$CC_SRC_PATH" -l "$LANGUAGE"

echo "check point 1"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/ssuet.example.com/users/Admin@ssuet.example.com/msp" cli peer chaincode instantiate -o orderer.example.com:7050 -C user -n mycc -l "$LANGUAGE" -v 1.3 -c '{"Args":[""]}'

sleep 10
echo "CheckPoint 1"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/ssuet.example.com/users/Admin@ssuet.example.com/msp" cli peer chaincode invoke -o orderer.example.com:7050 -C user -n mycc -c '{"function":"initLedger","Args":[""]}'

printf "\nTotal setup execution time : $(($(date +%s) - starttime)) secs ...\n\n\n"
printf "Start by installing required packages run 'npm install'\n"
printf "Then run 'node enrollAdmin.js', then 'node registerUser'\n\n"
printf "The 'node invoke.js' will fail until it has been updated with valid arguments\n"
printf "The 'node query.js' may be run at anytime once the user has been registered\n\n"
