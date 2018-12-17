#! /bin/sh

PYTHONVERSION=3.7.1

# Python-$PYTHONVERSION
echo "Downloading Python-$PYTHONVERSION"
mkdir tmp
(cd tmp ; curl -OL https://www.python.org/ftp/python/$PYTHONVERSION/Python-$PYTHONVERSION.tgz ;  tar -xvzf Python-$PYTHONVERSION.tgz ;  rm Python-$PYTHONVERSION.tgz)

# ffi is not done, because: only one line of change + can't download automatically. 
echo "Removing .DS_Store files"
find . -name .DS_Store -exec rm {} \;
echo "Computing patches for Python-$PYTHONVERSION"

diff -Naur tmp/Python-$PYTHONVERSION/Include Python-$PYTHONVERSION/Include > Python_Include.patch
diff -Naur tmp/Python-$PYTHONVERSION/Lib Python-$PYTHONVERSION/Lib > Python_Lib.patch
diff -Naur tmp/Python-$PYTHONVERSION/Modules Python-$PYTHONVERSION/Modules > Python_Modules.patch
diff -Naur tmp/Python-$PYTHONVERSION/Parser Python-$PYTHONVERSION/Parser > Python_Parser.patch
diff -Naur tmp/Python-$PYTHONVERSION/Objects Python-$PYTHONVERSION/Objects > Python_Objects.patch
diff -Naur tmp/Python-$PYTHONVERSION/Python Python-$PYTHONVERSION/Python > Python_Python.patch
diff -Naur tmp/Python-$PYTHONVERSION/setup.py Python-$PYTHONVERSION/setup.py > Python_setup.patch

echo "Done. Cleanup:"
rm -rf tmp/
