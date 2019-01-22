All of the codes have been verified under Linux with NCSIM, VCS and QUESTA.

to run the examples:
1. edit the setup.xxxx according to your simulator and UVM source code directory
2. input "source setup.xxxx" and hit enter according to your simulator
3. go to the directory you want to run simulation,
   a) if there is a script called "run"(for example src/ch2/section2.2/2.2.1), just input "./run" and hit enter
   b) if there is a script called "run_tc"(for example src/ch2/section2.5/2.5.2), just input "./run my_case0"( or "./run my_case1" if there is a file named "my_case1.sv") and hit enter

to clean the result:
go to the directory you want to clean, input "cleanfile" and hit enter


