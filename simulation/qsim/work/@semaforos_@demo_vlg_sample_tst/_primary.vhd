library verilog;
use verilog.vl_types.all;
entity Semaforos_Demo_vlg_sample_tst is
    port(
        CLOCK_50        : in     vl_logic;
        SW              : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end Semaforos_Demo_vlg_sample_tst;
