# Copyright (C) 2023  AGH University of Science and Technology
# MTM UEC2
# Author: Piotr Kaczmarczyk
#
# Description:
# Project detiles required for generate_bitstream.tcl
# Make sure that project_name, top_module and target are correct.
# Provide paths to all the files required for synthesis and implementation.
# Depending on the file type, it should be added in the corresponding section.
# If the project does not use files of some type, leave the corresponding section commented out.

#-----------------------------------------------------#
#                   Project details                   #
#-----------------------------------------------------#
# Project name                                  -- EDIT
set project_name RoboZap

# Top module name                               -- EDIT
set top_module top_vga_basys3

# FPGA device
set target xc7a35tcpg236-1

#-----------------------------------------------------#
#                    Design sources                   #
#-----------------------------------------------------#
# Specify .xdc files location                   -- EDIT
set xdc_files {
    constraints/top_vga_basys3.xdc
}

# Specify SystemVerilog design files location   -- EDIT
set sv_files {
    ../rtl/vga_files/vga_pkg.sv
    ../rtl/vga_files/vga_timing.sv
    ../rtl/vga_files/vga_if.sv
    ../rtl/vga_files/draw_bg.sv
    ../rtl/vga_files/draw_lever.sv
    ../rtl/vga_files/draw_stats.sv
    ../rtl/vga_files/draw_highlight.sv
    ../rtl/vga_files/draw_start_bg.sv
    ../rtl/vga_files/top_vga.sv
    rtl/top_vga_basys3.sv
    ../rtl/logic/game_state.sv
    ../rtl/logic/buttons_handler.sv
    ../rtl/logic/lever_selector.sv
    ../rtl/logic/top_logic.sv
    ../rtl/logic/health_calculator.sv
    ../rtl/logic/levers_info.sv
    ../rtl/logic/map_randomizer.sv
    ../rtl/logic/new_game.sv
    ../rtl/logic/start_game.sv
    ../rtl/logic/target.sv
    ../rtl/logic/uart_receiver.sv
    ../rtl/logic/uart_transmiter.sv
    ../rtl/logic/turn_handler.sv
    ../rtl/logic/who_won.sv \
}

# Specify Verilog design files location         -- EDIT
 set verilog_files {
     ../rtl/clk_wiz_0_clk_wiz.v
 }

# Specify VHDL design files location            -- EDIT
# set vhdl_files {
#    path/to/file.vhd
# }

# Specify files for a memory initialization     -- EDIT
# set mem_files {
#    path/to/file.data
# }
