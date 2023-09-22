help:
	@echo "Usage:"
	@echo "make VER=1.8 build"
	@echo "make VER=1.8 push"

build:
	docker build -t edrusb/jupyray:$(VER) .

push: build
	docker push edrusb/jupyray:$(VER)
