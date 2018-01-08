#!/bin/bash


# Python-3.6.4
echo "Downloading Python 3.6.4"
curl -OL https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
tar -xvzf Python-3.6.4.tgz
rm Python-3.6.4.tgz
echo "Downloading libffi-3.2.1" 
curl -OL ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz 
tar -xvzf libffi-3.2.1.tar.gz
rm libffi-3.2.1.tar.gz
echo "Applying patch to libffi-3.2.1"
(cd libffi-3.2.1 ; patch -p 1 < ../libffi-3.2.1_patch ; cd ..)
echo "Applying patch to Python-3.6.4"
(cd Python-3.6.4 ; patch -p 1 < ../Python.patch ; cd ..)

echo "All done. Now open libffi-3.2.1/libffi.xcodeproj and compile,\n
move libffi.a to this directory, open ios_system.xcodeproj and compile."
 

