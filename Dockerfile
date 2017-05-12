FROM jupyter/r-notebook:599db13f9123

MAINTAINER Reem Almugbel <reem2@uw.edu>

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

<<<<<<< HEAD
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

WORKDIR /home/jovyan
ADD . /home/jovyan
=======
RUN mkdir -p $RHOME_DIR

#To get R's blas and lapack must compile from source NOT from deb
RUN cd /tmp && wget https://cran.r-project.org/src/base/R-latest.tar.gz && \
    tar -xzvf R-latest.tar.gz && \
    cd /tmp/R-* && ./configure --prefix=$RENV_DIR --with-cairo && \
    cd /tmp/R-* && make -j 8 && \
    cd /tmp/R-* && make install rhome=$RHOME_DIR

RUN echo "options(bitmapType='cairo')" > /home/$NB_USER/.Rprofile
#need to install in xxx for libraries to be in the right place

RUN Rscript -e "install.packages(c('Cairo', 'RCurl', 'repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'), repos='http://cran.r-project.org');devtools::install_github('IRkernel/IRkernel');IRkernel::installspec()"

#install components of bioconductor for networkBMA
RUN Rscript -e "source('https://bioconductor.org/biocLite.R');biocLite(c('BMA','Rcpp','RcppArmadillo','RcppEigen','BH','leaps'),ask=FALSE)"

RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite(c('airway','BiocStyle','Rsamtools','GenomicAlignments','GenomicFeatures','BiocParallel','DESeq2','vsn','genefilter','AnnotationDbi','org.Hs.eg.db','Gviz','sva','fission'))" | R --vanilla

WORKDIR /home/$NB_USER/work
>>>>>>> origin/master
