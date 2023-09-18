help:
	@echo "make clean"
	@echo "make VER=1.8 build push"

build:
	docker build -t edrusb/raycluster:$(VER) .

push:
	docker push edrusb/raycluster:$(VER)
