library verilog;
use verilog.vl_types.all;
entity BinUDCntEnRst4_vlg_check_tst is
    port(
        cntOut          : in     vl_logic_vector(3 downto 0);
        count           : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end BinUDCntEnRst4_vlg_check_tst;
