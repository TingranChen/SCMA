module SHIFTER(
        input [63:0] shiftinput,
        input [3:0]conf,
        output [63:0] shiftoutput
    );
    assign shiftoutput = shiftinput << conf;


endmodule