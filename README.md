# Python3 for iOS -- with partial fork() and exec() ability

This project is a patch of Python-3.7.1, designed to make it compile on iOS. Python becomes a framework, and your programs call `python_main(argc, argv)` to execute python scripts. 

This framework was designed to be used in conjunction with [Blinkshell](https://github.com/holzschu/blink), [OpenTerm](https://github.com/holzschu/terminal) or [iVim](https://github.com/holzschu/iVim), but it can be used independently. 

# Installation (the easy way):

In your Xcode project, use the menu File -> "Swift Packages" -> "Add Package Dependency". In the window that opens, enter the address for this repository (https://github.com/holzschu/python3-ios.git). 

In the rightmost column, you will see "Swift Package Dependencies", and under it "Python". Under "Referenced Binaries", you have all the libraries, precompiled, as "xcframework". You can link with them, embed them, and Xcode will extract the iOS or Simulator version as needed.

# Compilation (the hard way):

- type `./compilePython.sh`. It will download the required packages, compile Python for iOS and the simulator, and create the XCframeworks. 

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

