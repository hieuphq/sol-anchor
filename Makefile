.PHONY: init run build-docker

build-docker:
	docker build -f ./Dockerfile -t hieuphq/sol-anchor:latest .