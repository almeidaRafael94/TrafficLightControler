library verilog;
use verilog.vl_types.all;
entity BinUDCntEnRst4 is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic;
        upDown_n        : in     vl_logic;
        cntOut          : out    vl_logic_vector(3 downto 0);
        count           : out    vl_logic
    );
end BinUDCntEnRst4;
