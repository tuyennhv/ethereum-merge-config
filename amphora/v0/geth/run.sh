#!/bin/bash


BOOTNODE=enode://0775bcba056e03dd80704197bad5e780d83e47930410e5d225077e3363e9f47a393ff41b70d7786bd6bd8623a2dd8231d19ae661f981fe0dd2c9db5018d32d38@167.71.19.77:30303

DATA_DIR=/eth1data

# Initialize geth
geth --catalyst --datadir $DATA_DIR init /genesis.json

# Run geth
geth \
  --datadir=$DATA_DIR \
  --networkid=1337201 --catalyst \
  --http --http.api "engine,net,eth,consensus" \
  --http.port 8545 \
  --http.addr 0.0.0.0 \
  --http.corsdomain "*" \
  --ws --ws.api "net,eth,consensus,engine" \
  --ws.port=8546 \
  --ws.addr 0.0.0.0 \
  --allow-insecure-unlock \
  --vmodule=rpc=5 \
  --bootnodes $BOOTNODE

