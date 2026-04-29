IMAGE_ID ?= DMGiulioRomano/pandoc-latex-docker-ubuntu
BASE_IMAGE_ID ?= dmgiulioromano/latex-docker-ubuntu
BASE_REGISTRY ?= ghcr.io
VERSION ?= latest

PANDOC_VERSION ?= 3.9.0.2
PANDOC_CROSSREF_VERSION ?= 0.3.23a

_default: all

all: minimal basic small medium full

define build
	docker build . -t $(IMAGE_ID):$(VERSION)-$(1) \
	    --build-arg BASE_IMAGE="$(BASE_REGISTRY)/$(BASE_IMAGE_ID):$(VERSION)-$(1)" \
	    --build-arg PANDOC_VERSION="$(PANDOC_VERSION)" \
	    --build-arg PANDOC_CROSSREF_VERSION="$(PANDOC_CROSSREF_VERSION)"
endef

minimal:
	$(call build,minimal)

basic:
	$(call build,basic)

small:
	$(call build,small)

medium:
	$(call build,medium)

full:
	$(call build,full)
	docker tag $(IMAGE_ID):$(VERSION)-full $(IMAGE_ID):$(VERSION)

test-%: %
	IMAGE_ID=$(IMAGE_ID) VERSION=$(VERSION) \
	    docker compose -f test.compose.yaml run --build sut-$*

test: minimal basic small medium full
	IMAGE_ID=$(IMAGE_ID) VERSION=$(VERSION) \
	    docker compose -f test.compose.yaml run --build sut

.PHONY: *
