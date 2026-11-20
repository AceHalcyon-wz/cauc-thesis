FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    texlive-xetex \
    texlive-luatex \
    texlive-lang-chinese \
    texlive-science \
    texlive-pictures \
    texlive-publishers \
    texlive-latex-extra \
    texlive-bibtex-extra \
    texlive-fonts-recommended \
    latexmk \
    fonts-wqy-microhei \
    fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
