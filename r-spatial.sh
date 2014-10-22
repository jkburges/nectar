#!/bin/bash

## Install R and geo-spatial dependencies
## mdsumner@gmail.com

## Paste all this text into Configuration Script or run as `sudo r-spatial.sh`
## - NOTE: commands run individually must be run as sudo for ubuntu account, 
##   otherwise they run as root in startup, or as sudo by normal bash script

## This script installs:
## - R with rgdal, ncdf4, and rgeos
## - including HDF4, HDF5, NetCDF-4 and OpenDAP capabilities
## - using Nectar image "NeCTAR Ubuntu 14.04 (Trusty) amd64"

## local time Tasmania
rm /etc/localtime
ln -s /usr/share/zoneinfo/Etc/GMT+10 /etc/localtime

## key for apt-get update, see http://cran.r-project.org/bin/linux/ubuntu/README
echo 'deb http://cran.csiro.au/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
apt-get update 
apt-get upgrade --assume-yes

## Install 3rd parties

## HDF4
apt-get install libhdf4-dev --assume-yes
apt-get install hdf4-tools --assume-yes

## NetCDF
apt-get install libnetcdf-dev --assume-yes
apt-get install netcdf-bin --assume-yes

## PROJ.4 and GDAL
apt-get install libproj --assume-yes
apt-get install libgdal-dev --assume-yes

## now R
apt-get install r-base r-base-dev --assume-yes
echo 'local({ r <- getOption("repos"); r["CRAN"] <- "http://cran.csiro.au/";options(repos = r); })' >> /etc/R/Rprofile.site
Rscript -e 'install.packages(c("rgdal", "rgeos", ncdf4"), "/usr/lib/R/site-library")'
