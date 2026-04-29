ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG PANDOC_VERSION
ARG PANDOC_CROSSREF_VERSION

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    && wget "https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-amd64.deb" \
    && dpkg -i "pandoc-${PANDOC_VERSION}-1-amd64.deb" \
    && rm "pandoc-${PANDOC_VERSION}-1-amd64.deb" \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget "https://github.com/lierdakil/pandoc-crossref/releases/download/v${PANDOC_CROSSREF_VERSION}/pandoc-crossref-Linux-X64.tar.xz" \
    -O /tmp/pandoc-crossref.tar.xz \
    && tar xf /tmp/pandoc-crossref.tar.xz -C /usr/local/bin pandoc-crossref \
    && rm /tmp/pandoc-crossref.tar.xz
