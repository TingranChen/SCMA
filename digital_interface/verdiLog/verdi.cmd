verdiWindowResize -win $_Verdi_1 -1 "27" "1920" "981"
wvCreateWindow
wvCloseWindow -win $_nWave2
wvCreateWindow
wvSetPosition -win $_nWave3 {("G1" 0)}
wvOpenFile -win $_nWave3 \
           {/data/home/chentingran/SCCM/digital_interface/results_simutop_SCMA/vcs_simutop.fsdb}
wvSetCursor -win $_nWave3 2383035.211451
wvSetCursor -win $_nWave3 5193214.001301
wvGetSignalOpen -win $_nWave3
wvGetSignalSetScope -win $_nWave3 "/SHIFTER"
wvGetSignalOpen -win $_nWave3
wvGetSignalSetScope -win $_nWave3 "/simu_top"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA/dut_SCMU_2"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA"
wvSetPosition -win $_nWave3 {("G1" 1)}
wvSetPosition -win $_nWave3 {("G1" 1)}
wvAddSignal -win $_nWave3 -clear
wvAddSignal -win $_nWave3 -group {"G1" \
{/simu_top/dut_SCMA/data_out\[31:0\]} \
}
wvAddSignal -win $_nWave3 -group {"G2" \
}
wvSelectSignal -win $_nWave3 {( "G1" 1 )} 
wvSetPosition -win $_nWave3 {("G1" 1)}
wvGetSignalClose -win $_nWave3
wvSetCursor -win $_nWave3 9343631.906311 -snap {("G2" 0)}
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvSetCursor -win $_nWave3 108581451.150559
wvSetCursor -win $_nWave3 4339351.984385 -snap {("G2" 0)}
wvGetSignalOpen -win $_nWave3
wvGetSignalSetScope -win $_nWave3 "/SHIFTER"
wvGetSignalSetScope -win $_nWave3 "/simu_top"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA/dut_SCMU_2"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA"
wvGetSignalSetScope -win $_nWave3 "/simu_top"
wvSetPosition -win $_nWave3 {("G1" 2)}
wvSetPosition -win $_nWave3 {("G1" 2)}
wvAddSignal -win $_nWave3 -clear
wvAddSignal -win $_nWave3 -group {"G1" \
{/simu_top/dut_SCMA/data_out\[31:0\]} \
{/simu_top/data_out\[31:0\]} \
}
wvAddSignal -win $_nWave3 -group {"G2" \
}
wvSelectSignal -win $_nWave3 {( "G1" 2 )} 
wvSetPosition -win $_nWave3 {("G1" 2)}
wvGetSignalClose -win $_nWave3
wvSetCursor -win $_nWave3 114347043.227066 -snap {("G2" 0)}
wvSetCursor -win $_nWave3 138817215.458686 -snap {("G2" 0)}
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvSetCursor -win $_nWave3 144956375.276513 -snap {("G2" 0)}
wvSetCursor -win $_nWave3 137606676.903058 -snap {("G2" 0)}
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvGetSignalOpen -win $_nWave3
wvGetSignalSetScope -win $_nWave3 "/SHIFTER"
wvGetSignalSetScope -win $_nWave3 "/simu_top"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA/dut_SCMU_2"
wvGetSignalSetScope -win $_nWave3 "/simu_top"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA/dut_SCMU_3"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA/dut_SCMU_0"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA"
wvSetPosition -win $_nWave3 {("G1" 4)}
wvSetPosition -win $_nWave3 {("G1" 4)}
wvAddSignal -win $_nWave3 -clear
wvAddSignal -win $_nWave3 -group {"G1" \
{/simu_top/dut_SCMA/data_out\[31:0\]} \
{/simu_top/data_out\[31:0\]} \
{/simu_top/dut_SCMA/a_in\[26:0\]} \
{/simu_top/dut_SCMA/data_in\[35:0\]} \
}
wvAddSignal -win $_nWave3 -group {"G2" \
}
wvSelectSignal -win $_nWave3 {( "G1" 4 )} 
wvSetPosition -win $_nWave3 {("G1" 4)}
wvGetSignalClose -win $_nWave3
wvSetCursor -win $_nWave3 19471083.929733 -snap {("G2" 0)}
wvGetSignalOpen -win $_nWave3
wvGetSignalSetScope -win $_nWave3 "/SHIFTER"
wvGetSignalSetScope -win $_nWave3 "/simu_top"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA/dut_SCMU_2"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA/dut_SCMU_3"
wvGetSignalSetScope -win $_nWave3 "/simu_top/dut_SCMA"
wvSetCursor -win $_nWave3 44438441.639558 -snap {("G2" 0)}
wvSetPosition -win $_nWave3 {("G1" 5)}
wvSetPosition -win $_nWave3 {("G1" 5)}
wvAddSignal -win $_nWave3 -clear
wvAddSignal -win $_nWave3 -group {"G1" \
{/simu_top/dut_SCMA/data_out\[31:0\]} \
{/simu_top/data_out\[31:0\]} \
{/simu_top/dut_SCMA/a_in\[26:0\]} \
{/simu_top/dut_SCMA/data_in\[35:0\]} \
{/simu_top/dut_SCMA/data_out\[31:0\]} \
}
wvAddSignal -win $_nWave3 -group {"G2" \
}
wvSelectSignal -win $_nWave3 {( "G1" 5 )} 
wvSetPosition -win $_nWave3 {("G1" 5)}
wvGetSignalClose -win $_nWave3
wvSetCursor -win $_nWave3 54706402.602472 -snap {("G2" 0)}
wvSelectSignal -win $_nWave3 {( "G1" 2 )} 
wvTpfCloseForm -win $_nWave3
wvGetSignalClose -win $_nWave3
wvCloseWindow -win $_nWave3
wvCreateWindow
wvGetSignalOpen -win $_nWave4
wvGetSignalSetScope -win $_nWave4 "/SHIFTER"
wvGetSignalSetScope -win $_nWave4 "/simu_top"
wvGetSignalSetScope -win $_nWave4 "/simu_top/dut_SCMA"
wvGetSignalSetScope -win $_nWave4 "/simu_top/dut_SCMA/dut_SCMU_2"
wvSetPosition -win $_nWave4 {("G1" 1)}
wvSetPosition -win $_nWave4 {("G1" 1)}
wvAddSignal -win $_nWave4 -clear
wvAddSignal -win $_nWave4 -group {"G1" \
{/simu_top/dut_SCMA/dut_SCMU_2/RD_EN_inputfifo_IO_b} \
}
wvAddSignal -win $_nWave4 -group {"G2" \
}
wvSelectSignal -win $_nWave4 {( "G1" 1 )} 
wvSetPosition -win $_nWave4 {("G1" 1)}
wvGetSignalClose -win $_nWave4
wvSetCursor -win $_nWave4 8237975.783274 -snap {("G2" 0)}
wvZoomOut -win $_nWave4
wvZoomOut -win $_nWave4
wvGetSignalOpen -win $_nWave4
wvGetSignalSetScope -win $_nWave4 "/SHIFTER"
wvGetSignalSetScope -win $_nWave4 "/simu_top"
wvGetSignalSetScope -win $_nWave4 "/simu_top/dut_SCMA"
wvGetSignalSetScope -win $_nWave4 "/simu_top/dut_SCMA/dut_SCMU_2"
wvGetSignalSetScope -win $_nWave4 "/simu_top/dut_SCMA"
wvSetPosition -win $_nWave4 {("G1" 2)}
wvSetPosition -win $_nWave4 {("G1" 2)}
wvAddSignal -win $_nWave4 -clear
wvAddSignal -win $_nWave4 -group {"G1" \
{/simu_top/dut_SCMA/dut_SCMU_2/RD_EN_inputfifo_IO_b} \
{/simu_top/dut_SCMA/a_in\[26:0\]} \
}
wvAddSignal -win $_nWave4 -group {"G2" \
}
wvSelectSignal -win $_nWave4 {( "G1" 2 )} 
wvSetPosition -win $_nWave4 {("G1" 2)}
wvGetSignalClose -win $_nWave4
wvSelectSignal -win $_nWave4 {( "G1" 1 )} 
wvCut -win $_nWave4
wvSetPosition -win $_nWave4 {("G2" 0)}
wvSetPosition -win $_nWave4 {("G1" 1)}
wvSetCursor -win $_nWave4 23414052.579505 -snap {("G2" 0)}
wvSetCursor -win $_nWave4 37514356.843345 -snap {("G2" 0)}
wvGetSignalOpen -win $_nWave4
wvGetSignalSetScope -win $_nWave4 "/SHIFTER"
wvGetSignalSetScope -win $_nWave4 "/simu_top"
wvGetSignalSetScope -win $_nWave4 "/simu_top/dut_SCMA"
wvGetSignalSetScope -win $_nWave4 "/simu_top/dut_SCMA/dut_SCMU_2"
wvGetSignalSetScope -win $_nWave4 "/simu_top/dut_SCMA"
wvSetPosition -win $_nWave4 {("G1" 4)}
wvSetPosition -win $_nWave4 {("G1" 4)}
wvAddSignal -win $_nWave4 -clear
wvAddSignal -win $_nWave4 -group {"G1" \
{/simu_top/dut_SCMA/a_in\[26:0\]} \
{/simu_top/dut_SCMA/clk} \
{/simu_top/dut_SCMA/data_out\[31:0\]} \
{/simu_top/dut_SCMA/data_out_0\[31:0\]} \
}
wvAddSignal -win $_nWave4 -group {"G2" \
}
wvSelectSignal -win $_nWave4 {( "G1" 4 )} 
wvSetPosition -win $_nWave4 {("G1" 4)}
wvGetSignalClose -win $_nWave4
wvSelectSignal -win $_nWave4 {( "G1" 3 )} 
wvSetPosition -win $_nWave4 {("G1" 3)}
wvExpandBus -win $_nWave4 {("G1" 3)}
wvSetPosition -win $_nWave4 {("G1" 36)}
wvSelectSignal -win $_nWave4 {( "G1" 27 )} 
wvGetSignalOpen -win $_nWave4
wvGetSignalSetScope -win $_nWave4 "/SHIFTER"
wvGetSignalSetScope -win $_nWave4 "/simu_top"
wvGetSignalSetScope -win $_nWave4 "/simu_top/dut_SCMA"
wvGetSignalSetScope -win $_nWave4 "/simu_top/dut_SCMA/dut_SCMU_2"
wvGetSignalSetScope -win $_nWave4 "/simu_top/dut_SCMA"
wvSetPosition -win $_nWave4 {("G1" 37)}
wvSetPosition -win $_nWave4 {("G1" 37)}
wvAddSignal -win $_nWave4 -clear
wvAddSignal -win $_nWave4 -group {"G1" \
{/simu_top/dut_SCMA/a_in\[26:0\]} \
{/simu_top/dut_SCMA/clk} \
{/simu_top/dut_SCMA/data_out\[31:0\]} \
{/simu_top/dut_SCMA/data_out\[31\]} \
{/simu_top/dut_SCMA/data_out\[30\]} \
{/simu_top/dut_SCMA/data_out\[29\]} \
{/simu_top/dut_SCMA/data_out\[28\]} \
{/simu_top/dut_SCMA/data_out\[27\]} \
{/simu_top/dut_SCMA/data_out\[26\]} \
{/simu_top/dut_SCMA/data_out\[25\]} \
{/simu_top/dut_SCMA/data_out\[24\]} \
{/simu_top/dut_SCMA/data_out\[23\]} \
{/simu_top/dut_SCMA/data_out\[22\]} \
{/simu_top/dut_SCMA/data_out\[21\]} \
{/simu_top/dut_SCMA/data_out\[20\]} \
{/simu_top/dut_SCMA/data_out\[19\]} \
{/simu_top/dut_SCMA/data_out\[18\]} \
{/simu_top/dut_SCMA/data_out\[17\]} \
{/simu_top/dut_SCMA/data_out\[16\]} \
{/simu_top/dut_SCMA/data_out\[15\]} \
{/simu_top/dut_SCMA/data_out\[14\]} \
{/simu_top/dut_SCMA/data_out\[13\]} \
{/simu_top/dut_SCMA/data_out\[12\]} \
{/simu_top/dut_SCMA/data_out\[11\]} \
{/simu_top/dut_SCMA/data_out\[10\]} \
{/simu_top/dut_SCMA/data_out\[9\]} \
{/simu_top/dut_SCMA/data_out\[8\]} \
{/simu_top/dut_SCMA/data_out\[7\]} \
{/simu_top/dut_SCMA/data_out\[6\]} \
{/simu_top/dut_SCMA/data_out\[5\]} \
{/simu_top/dut_SCMA/data_out\[4\]} \
{/simu_top/dut_SCMA/data_out\[3\]} \
{/simu_top/dut_SCMA/data_out\[2\]} \
{/simu_top/dut_SCMA/data_out\[1\]} \
{/simu_top/dut_SCMA/data_out\[0\]} \
{/simu_top/dut_SCMA/data_out_0\[31:0\]} \
{/simu_top/dut_SCMA/data_out_2\[31:0\]} \
}
wvAddSignal -win $_nWave4 -group {"G2" \
}
wvSelectSignal -win $_nWave4 {( "G1" 37 )} 
wvSetPosition -win $_nWave4 {("G1" 37)}
wvGetSignalClose -win $_nWave4
wvDisplayGridCount -win $_nWave4 -off
wvGetSignalClose -win $_nWave4
wvReloadFile -win $_nWave4
wvSelectSignal -win $_nWave4 {( "G1" 26 )} 
wvScrollUp -win $_nWave4 19
wvSelectSignal -win $_nWave4 {( "G1" 26 )} 
wvSelectSignal -win $_nWave4 {( "G1" 26 )} 
wvSetCursor -win $_nWave4 61297756.004756
wvTpfCloseForm -win $_nWave4
wvGetSignalClose -win $_nWave4
wvCloseWindow -win $_nWave4
wvCreateWindow
wvGetSignalOpen -win $_nWave5
wvGetSignalSetScope -win $_nWave5 "/SHIFTER"
wvGetSignalSetScope -win $_nWave5 "/simu_top"
wvGetSignalSetScope -win $_nWave5 "/simu_top/dut_SCMA"
wvSetPosition -win $_nWave5 {("G1" 3)}
wvSetPosition -win $_nWave5 {("G1" 3)}
wvAddSignal -win $_nWave5 -clear
wvAddSignal -win $_nWave5 -group {"G1" \
{/simu_top/dut_SCMA/a_in\[26:0\]} \
{/simu_top/dut_SCMA/data_in\[35:0\]} \
{/simu_top/dut_SCMA/data_out\[31:0\]} \
}
wvAddSignal -win $_nWave5 -group {"G2" \
}
wvSelectSignal -win $_nWave5 {( "G1" 3 )} 
wvSetPosition -win $_nWave5 {("G1" 3)}
wvGetSignalClose -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvSetCursor -win $_nWave5 115070500.000000 -snap {("G2" 0)}
wvSetCursor -win $_nWave5 6071500.000000 -snap {("G2" 0)}
wvSelectSignal -win $_nWave5 {( "G1" 2 )} 
wvSetPosition -win $_nWave5 {("G1" 2)}
wvExpandBus -win $_nWave5 {("G1" 2)}
wvSetPosition -win $_nWave5 {("G1" 39)}
wvDisplayGridCount -win $_nWave5 -off
wvGetSignalClose -win $_nWave5
wvReloadFile -win $_nWave5
wvScrollDown -win $_nWave5 1
wvScrollDown -win $_nWave5 1
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollUp -win $_nWave5 1
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
wvScrollDown -win $_nWave5 0
