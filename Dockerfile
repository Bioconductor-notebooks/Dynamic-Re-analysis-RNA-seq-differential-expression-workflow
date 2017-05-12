FROM jupyter/r-notebook:599db13f9123

MAINTAINER Yashaswi Tamta <yasht7@uw.edu>

USER root

# Customized using Jupyter Notebook R Stack https://github.com/jupyter/docker-stacks/tree/master/r-notebook


# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

# R packages

RUN conda config --add channels r
RUN conda config --add channels bioconda

RUN conda install --quiet --yes \
    'r-base=3.3.2' \
    'r-irkernel=0.7*' \
    'r-plyr=1.8*' \
    'r-devtools=1.12*' \
    'r-shiny=0.14*' \
    'r-rmarkdown=1.2*' \
    'r-rsqlite=1.1*' \
    'r-reshape2=1.4*' \
    'r-nycflights13=0.2*' \
    'r-caret=6.0*' \
    'r-rcurl=1.95*' \
    'r-crayon=1.3*' && conda clean -tipsy
    
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('limma')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('AnnotationDbi')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('samr')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('hugene20stprobeset.db')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('hgu133plus2.db')" | R --vanilla

RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('airway')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('BiocStyle')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('Rsamtools')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('GenomicAlignments')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('GenomicFeatures')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('BiocParallel')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('DESeq2')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('vsn')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('genefilter')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('AnnotationDbi')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('org.Hs.eg.db')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('Gviz')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('sva')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('fission')" | R --vanilla

WORKDIR /home/jovyan
ADD . /home/jovyan
