help:
	@echo "make clean"
	@echo "make VER=1.8 build push"

build:
	docker build -t edrusb/jupyray:$(VER) .

push: build
	docker push edrusb/jupyray:$(VER)
