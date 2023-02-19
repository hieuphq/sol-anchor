.PHONY: init run build-docker

build-docker:
	docker build -f ./Dockerfile -t solana-anchor:latest .