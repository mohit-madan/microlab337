transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/TwosComplement.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/registers.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/mux4to1.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/mux2to1.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/decoder3_16.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/alu.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/trail_zero7.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/temp_reg.vhdl}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/sign_ext.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/regfile.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/ram.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/priorityEncoder.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/mux8to1.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/TopLevel.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/controlPath/FSM_new.vhd}
vcom -93 -work work {/home/shrey/Documents/microlab337/MicroLab/datapath.vhd}

