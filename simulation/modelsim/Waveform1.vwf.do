vlog -work work Waveform1.vwf.vtvsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.BinUDCntEnRst4_vlg_vec_tst -voptargs="+acc"
add wave /*
run -all
