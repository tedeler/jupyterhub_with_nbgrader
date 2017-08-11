all: build run
	@echo "DONE"

build:
	docker build -t jupyterhubtest .

run:
	docker run -it --rm -p8000:8000 jupyterhubtest jupyterhub
