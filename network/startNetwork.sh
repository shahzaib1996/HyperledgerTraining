
rm -fr config/*
#rm -fr crypto-config/*


# Intializing Variables
export MSYS_NO_PATHCONV=1
export FABRIC_CFG_PATH=${PWD}
CHANNEL_NAME1=user

echo "Generating Crypto Materials in to crypto-config folder..."
#cryptogen generate --config=./crypto-config.yaml

echo "Generating Genesis Block Configuration in config folder..."
configtxgen -profile OneOrgOrdererGenesis -outputBlock ./config/genesis.block

echo "Creating Channel Configuration in config folder...1"
configtxgen -profile OneOrgChannel1 -outputCreateChannelTx ./config/channel1.tx -channelID $CHANNEL_NAME1


# generate anchor peer transaction
# configtxgen -profile OneOrgChannel -outputAnchorPeersUpdate ./config/SSUETMSPanchors.tx -channelID $CHANNEL_NAME -asOrg SSUETMSP

echo "Shutting down if any previous network is running..."
docker-compose -f docker-compose.yml down

echo "##### STARTING NETWORK #####"
docker-compose -f docker-compose.yml up -d

# wait for Hyperledger Fabric to start
# Setting Timeout 
export FABRIC_START_TIMEOUT=50

sleep ${FABRIC_START_TIMEOUT}

echo "Creating channel..."
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer0.ssuet.example.com peer channel create -o orderer.example.com:7050 -c $CHANNEL_NAME1 -f /etc/hyperledger/configtx/channel1.tx



echo "##########################################"
echo "######### peer0 joining channels #########"
echo "##########################################"

echo "Joining peer0.ssuet.example.com to the channel...USER"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer0.ssuet.example.com peer channel join -b user.block



echo "##########################################"
echo "######### peer1 Fetching channels #########"
echo "##########################################"

echo "peer1.org1.example.com fetching USER Configuration Block..."
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer1.ssuet.example.com peer channel fetch 0 user.block -c user -o orderer.example.com:7050


echo "##########################################"
echo "######### peer1 joining channels #########"
echo "##########################################"

echo "Joining peer1.org1.example.com to the channel...USER"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer1.ssuet.example.com peer channel join -b user.block




echo "##########################################"
echo "######### peer2 Fetching channels #########"
echo "##########################################"

echo "peer2.org1.example.com fetching USER Configuration Block..."
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer2.ssuet.example.com peer channel fetch 0 user.block -c user -o orderer.example.com:7050



echo "##########################################"
echo "######### peer2 joining channels #########"
echo "##########################################"

echo "Joining peer2.org1.example.com to the channel...USER"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer2.ssuet.example.com peer channel join -b user.block






echo "##########################################"
echo "######### peer3 Fetching channels #########"
echo "##########################################"

echo "peer2.org1.example.com fetching USER Configuration Block..."
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer3.ssuet.example.com peer channel fetch 0 user.block -c user -o orderer.example.com:7050


echo "##########################################"
echo "######### peer3 joining channels #########"
echo "##########################################"

echo "Joining peer2.org1.example.com to the channel...USER"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer3.ssuet.example.com peer channel join -b user.block




echo "##########################################"
echo "######### peer4 Fetching channels #########"
echo "##########################################"

echo "peer2.org1.example.com fetching USER Configuration Block..."
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer4.ssuet.example.com peer channel fetch 0 user.block -c user -o orderer.example.com:7050



echo "##########################################"
echo "######### peer4 joining channels #########"
echo "##########################################"

echo "Joining peer2.org1.example.com to the channel...USER"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer4.ssuet.example.com peer channel join -b user.block





echo "##########################################"
echo "######### peer5 Fetching channels #########"
echo "##########################################"

echo "peer2.org1.example.com fetching USER Configuration Block..."
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer5.ssuet.example.com peer channel fetch 0 user.block -c user -o orderer.example.com:7050



echo "##########################################"
echo "######### peer5 joining channels #########"
echo "##########################################"

echo "Joining peer2.org1.example.com to the channel...USER"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer5.ssuet.example.com peer channel join -b user.block





echo "##########################################"
echo "######### peer6 Fetching channels #########"
echo "##########################################"

echo "peer2.org1.example.com fetching USER Configuration Block..."
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer6.ssuet.example.com peer channel fetch 0 user.block -c user -o orderer.example.com:7050


echo "##########################################"
echo "######### peer6 joining channels #########"
echo "##########################################"

echo "Joining peer2.org1.example.com to the channel...USER"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer6.ssuet.example.com peer channel join -b user.block







echo "##########################################"
echo "######### peer7 Fetching channels #########"
echo "##########################################"

echo "peer2.org1.example.com fetching USER Configuration Block..."
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer7.ssuet.example.com peer channel fetch 0 user.block -c user -o orderer.example.com:7050


echo "##########################################"
echo "######### peer7 joining channels #########"
echo "##########################################"

echo "Joining peer2.org1.example.com to the channel...USER"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer7.ssuet.example.com peer channel join -b user.block





echo "#################################################"
echo "######### DISPLAYING PEERS CHANNEL LIST #########"
echo "#################################################"

sleep 2

echo "LISTING PEER0 CHANNELS"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer0.ssuet.example.com peer channel list

sleep 2

echo "LISTING PEER1 CHANNELS"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer1.ssuet.example.com peer channel list

sleep 2

echo "LISTING PEER2 CHANNELS"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer2.ssuet.example.com peer channel list

sleep 2

echo "LISTING PEER3 CHANNELS"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer3.ssuet.example.com peer channel list

sleep 2

echo "LISTING PEER4 CHANNELS"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer4.ssuet.example.com peer channel list

sleep 2

echo "LISTING PEER5 CHANNELS"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer5.ssuet.example.com peer channel list

sleep 2

echo "LISTING PEER6 CHANNELS"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer6.ssuet.example.com peer channel list

sleep 2

echo "LISTING PEER7 CHANNELS"
docker exec -e "CORE_PEER_LOCALMSPID=SSUETMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@ssuet.example.com/msp" peer7.ssuet.example.com peer channel list

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "%%        DISPLAYING DOCKER CONTAINERS        %%"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
sleep 4
docker ps 

