# Comsc210-Labs
RWU Comsc210 Lab Assignments
MIPS Assembly Language Program exaqmples for the class


C Programming - Windows Setup steps
Setup VS Code
1. install VS Code
2. Install C C++ Extension
3. Install C C++ Extension Pack
4. Install coderunner extension
5. Install Mingw-w64 via MSYS2, which provides up-to-date native builds of GCC, Mingw-w64, 
and other helpful C++ tools and libraries. You can download the latest installer from the MSYS2 page
https://www.msys2.org/
5. Follow the instructions to install MYSYS in the default directory: c:\MYSYS64
6. Once the install is done click on 'Run MYSYS Now' to bring up the MYSYS command prompt
7. At the command prompt enter: pacman -Syu
8. Open mysys command window again double click: C:\mysys64\msys2_shell
9. At the command prompt: pacman -Su
10. Open the command again if it has closed then enter: pacman -S --needed base-devel mingw-w64-x86_64-toolchain
11. In VS Code edit the compiler configuration uuse the Intellisense UI enter: cntrl-shift-P then begin typing 'edit configuration' to bring up the Intellisens UI editor
12. In the Intellisense UI:  configration name: Win32
13. Specify a compiler path from the dropdown: C:/msys64/mingw64/bin/gcc.exe
14. Intellisense Mode from the dropdown: ${default]
15. Restart VS Code, enter and save helloworld.cpp program run using the coderunner 'play' button top right of your screen
16. Once you have the compiler working you want to install the 'coderunner' extension so you can get user input in the terminal
17. After code runner is installed go into File>Preferences>Settings Type 'code runner' in the text box check the box 'run in terminal'
18. Try a C program that asks for user input such as CircleArea.cpp
