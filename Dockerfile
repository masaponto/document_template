FROM haskell:8.0

MAINTAINER masaponto <masaponto@gmail.com>

# install latex packages
RUN apt-get update -y && \
    apt-get install -y \
    texlive-full \
    texlive-lang-japanese

RUN apt-get install -y \
     curl \
     bzip2

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/share/texlive/texmf-dist/tex/latex/jlisting && \
    curl http://iij.dl.sourceforge.jp/mytexpert/26068/jlisting.sty.bz2 | \
    bunzip2 > /usr/share/texlive/texmf-dist/tex/latex/jlisting/jlisting.sty && \
    mktexlsr


RUN cabal update && cabal install pandoc pandoc-crossref

WORKDIR /workspace
ENTRYPOINT ["/root/.cabal/bin/pandoc"]

CMD ["--help"]