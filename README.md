# Python3 for iOS -- with partial fork() and exec() ability

This project is a patch of Python-3.7.1, designed to make it compile on iOS. Python becomes a framework, and your programs call `python_main(argc, argv)` to execute python scripts. 

This framework was designed to be used in conjunction with [Blinkshell](https://github.com/holzschu/blink), [OpenTerm](https://github.com/holzschu/terminal) or [iVim](https://github.com/holzschu/iVim), but it can be used independently. 

# Compilation:

- type `getPackages.sh`

This will download the Python-3.7.1 source code, patch it, and compile it. It will also download libffi-3.2.1 and zeromq-4.2.5, patch them and compile them for iOS.

At the end of the script, you have a compiled framework in `Python3_ios/build/Debug-iphoneos/Python3_ios.framework`, which you can link with your application.

# Installation (on your device)

Once you have compiled the Python3-ios framework, you can link it with your favorite app (I've done it with [Blinkshell](https://github.com/holzschu/blink), [OpenTerm](https://github.com/holzschu/terminal)  and [iVim](https://github.com/holzschu/iVim)). 

You will then need to transfer the Python scripts to your device:
- `tar -cvzf pythonScripts.tar.gz Python-3.7.1/Lib/`
- transfer the pythonScripts.tar.gz on the device, for example using iTunes or iCloud drive.
- on the iOS device: `tar -xvzf pythonScripts.tar.gz`
- `mv Lib ../Library/lib/python3.7`

Also transfer the scripts: 
- `tar -cvzf binaries.tar.gz Python-3.7.1/Tools/scripts/`
- transfer the binaries.tar.gz on your device, for example using iTunes
- on the iOS device: `tar -xvzf binaries.tar.gz` 
- `mv Tools/scripts ../Library/bin`

This installation comes with many packages already installed: pip, setuptools, cffi...

Inside Python, you can call the shell commands defined by the frameworks: ls, cat, grep... 

In the shell, you can use all Python scripts: pydoc, which.py, diff.py... 

# Installing new packages

To install more packages, you have to try different options, in order of complexity:
- `pip install packagename`, which will work most of the time.
- if the package tries to compile C extensions, install will fail (obviously). Trying to run the compiler raises an exception, and the setup script then adapts itself. If this does not work (for example for cffi), you will have to add the C files to the Xcode project yourself. 

# Jupyter

This version of Python is robust enough to run Jupyter locally, without a network connection. You can even have multiple notebooks open at the same time. All the packages required are present in `Python-3.7.1/Lib/site-packages/` (which is a copy of `site-packages`). 

To run Jupyter, we need to have several copie of Python3 running simultaneously (one for the server, one for each client). Given the limitations of iOS, this is done by having several frameworks, with slightly different names, loaded as required. The limitation is: you can't run more than 10 python3 scripts at the same time. 

There is (currently) everything you need to run Jupyter, but not numpy or matplotlib, which is a huge limitation. I'm working on it.

The latest commit of [Blinkshell](https://github.com/holzschu/blink) contains the required changes to work with Jupyter. 
