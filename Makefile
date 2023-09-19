help:
	@echo "make clean"
	@echo "make VER=1.8 build push"

build:
	docker build -t edrusb/ray:$(VER) .

push: build
	docker push edrusb/ray:$(VER)
