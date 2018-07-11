FROM centos:latest
ARG TIDYVERSE=0
ARG R_VERSION=3.5.0
RUN yum install -y openssl-devel udunits2-devel libssh2-devel wget xz-devel java-1.8.0-openjdk-devel pcre-devel curl-devel make gcc-c++ gcc-gfortran zlib-devel bzip2-devel perl libxml2-devel
RUN wget https://cran.r-project.org/src/base/R-3/R-$R_VERSION.tar.gz && tar -zxvf R-$R_VERSION.tar.gz && cd R-$R_VERSION && ./configure F77=gfortran --enable-R-shlib --enable-memory-profiling --with-readline=no --with-x=no --prefix /libs/R && make -j4 && make -j4 prefix=/libs/R install && rm -r /R-$R_VERSION.tar.gz && rm -r /R-$R_VERSION
ENV PATH=/libs/R/bin:$PATH 
RUN yum remove -y wget && yum clean all -y && rm -rf /var/cache/yum
RUN if [ $TIDYVERSE == 1 ]; then echo "install.packages('tidyverse', repos='http://cran.us.r-project.org')" > /install_packages.R && Rscript /install_packages.R && rm /install_packages.R; fi
