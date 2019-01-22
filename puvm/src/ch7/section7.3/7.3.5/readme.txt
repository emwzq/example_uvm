there is error with Cadence's simulator while Synopsys' and Mentor's simulators are OK.
Cadence's simulation doesn't support VPI's part select function while this example employs this function.  
In my_case0.sv, the poke and peek function employ VPI part select function.
To avoid this issue, please refer to section 7.4.4
