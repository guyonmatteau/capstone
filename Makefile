.PHONY: chain deploy test lint clean
include .env
export 

### GLOBALS
CONTRACT=SharedWallet
NETWORK=localhost
DOCKER_IMAGE=sharedwallet
DOCKER_TAG=$(shell git branch --show-current)
DOCKER_ENV=-e ALCHEMY_API_KEY=$(ALCHEMY_API_KEY) -e PRIVATE_KEY=$(PRIVATE_KEY)
DOCKER_PORTS=-p 8545:8545


chain:
	npx hardhat node --verbose

accounts: 
	npx hardhat run --network localhost scripts/accounts.js

deploy.localhost: 
	forge create --private-key ${PRIVATE_KEY1} src/Wallet.sol:Wallet --verify

deploy.goerli:
	forge create --private-key ${PRIVATE_KEY_GOERLI} src/Wallet.sol:Wallet --rpc-url https://eth-mainnet.g.alchemy.com/v2/${ALCHEMY_KEY} --verify

test:
	forge test -vvvv

console:
	npx hardhat console --network localhost

lint:
	forge fmt 

clean:
	-rm -r build cache
