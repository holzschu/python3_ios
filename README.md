# Python3 for iOS -- with partial fork() and exec() ability

This project is a patch of Python-3.7.1, designed to make it compile on iOS. Python becomes a framework, and your programs call `python_main(argc, argv)` to execute python scripts. 

This framework was designed to be used in conjunction with [Blinkshell](https://github.com/holzschu/blink), [OpenTerm](https://github.com/holzschu/terminal) or [iVim](https://github.com/holzschu/iVim), but it can be used independently. 

# Installation (the easy way):

If you compile [Blinkshell](https://github.com/holzschu/blink) or [OpenTerm](https://github.com/holzschu/terminal) using the scripts provided, the script downloads pre-compiled versions of the frameworks, including Python3_ios. Then you can install the app on your device using Xcode, and go straight to installing the scripts and commands.

# Compilation (the hard way):

If you want to compile the framework yourself: 

- type `getPackages.sh`

This will download the Python-3.7.1 source code, patch it, and compile it. It will also download several libraries that are required for Python: libffi-3.2.1, zeromq-4.2.5, libpng, freetype and harfbuzz, patch them and compile them for iOS. `getPackages.sh` does all the compilation for you, but it is becoming a bit long to run. 

At the end of the script, you have a compiled framework in `Python3_ios/build/Debug-iphoneos/Python3_ios.framework`, which you can link with your application.

If you edit the Python code, you only need to recompile the Python framework, using `compilePython.sh` (which calls `xcodebuild -project Python3_ios/Python3_ios.xcodeproj -sdk iphoneos -arch arm64 -configuration Debug -quiet`). 

Once you have compiled the Python3-ios framework, you can link it with your favorite app (I've done it with [Blinkshell](https://github.com/holzschu/blink), [OpenTerm](https://github.com/holzschu/terminal)  and [iVim](https://github.com/holzschu/iVim)). 

# Installing scripts and commands on your device

Once you have a working app with the Python3 framework installed and liked, you still need to transfer the Python scripts on your device.
The easiest way is to use the [Github release](https://github.com/holzschu/python3_ios/releases/download/v1.0/release.tar.gz).

On your iDevice (iPhone, iPad...):
- Download the archive: `curl -OL https://github.com/holzschu/python3_ios/releases/download/v1.0/release.tar.gz`
- Expand the archive: `tar xzf release.tar.gz`
- Move the directories to their place: `mv bin ../Library`, `mv bin3 ../Library`, `mv lib ../Library`

This will let you access all the modules and commands. Inside the shell, typing a command that is defined by a Python script and placed inside `$HOME/Library/bin` will work (so `pip3` works, `diff.py`works, etc). 

# Installing new packages

This installation comes with a *lot* of pre-installed packages (try `pip3 freeze` for a complete list). 

If you need to install more packages, you have two choices:
- `pip3 install packagename` will work **if** the package is pure Python (if there are no C or C++ source files to compile) (that is, most of the time). 
- If the package needs to compile a module, then you can't install locally. You will need to edit the Xcode project, add module source files and add the module to `config.c`. 

# Jupyter, numpy, matplotlib

This version of Python can run Jupyter locally, without a network connection. You can even have multiple notebooks open at the same time. All the packages required are present in `Python-3.7.1/Lib/site-packages/` (which you installed on your device). To start a notebook, type: `jupyter-notebook` in the shell. 

To run Jupyter, we need to have several copie of Python3 running simultaneously (one for the server, one for each client). Given the limitations of iOS, this is done by having several frameworks, with slightly different names, loaded as required. The limitation is: you can't run more than 10 python3 scripts at the same time. 

The latest commits of [Blinkshell](https://github.com/holzschu/blink) and [OpenTerm](https://github.com/holzschu/terminal) contain the required changes to work with Jupyter. 



