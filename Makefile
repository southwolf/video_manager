env?=qa
datetime:=$(shell /bin/date "+%Y%m%d%H%M%S")
version?=latest
base_image:=ruby-base:1.00
image_name:=video-manager:$(env)-$(version)

build_base:
	DOCKERFILE=./build/Dockerfile.base TAG=$(base_image) sh ./build/scripts/build-if-missing.sh

build: build_base
	docker build -f ./build/Dockerfile.video-manager -t $(image_name) --build-arg ENV=$(env) .

test:
	IMAGE_NAME=$(image_name) sh ./build/scripts/test.sh

build_test: build
	IMAGE_NAME=$(image_name) sh ./build/scripts/test.sh

run:
	IMAGE_NAME=$(image_name) sh ./build/scripts/run.sh

test_native:
	rspec
	cd ./services/videos
	rspec
	cd ./services/comments
	rspec