/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Package with vga related constants.
 */

 package vga_pkg;

    // Parameters for VGA Display 800 x 600 @ 60fps using a 40 MHz clock;
    localparam HOR_PIXELS = 1024;
    localparam VER_PIXELS = 768;

    localparam H_MAX = 1344;
    localparam HOR_BLANK_START = 1024;
    localparam HOR_SYNC_START = 1048;
    localparam HOR_SYNC_STOP = 1184;

    localparam V_MAX = 806;
    localparam VER_BLANK_START = 768;
    localparam VER_SYNC_START = 771;
    localparam VER_SYNC_STOP = 777;
    
    
    
    
    // Add VGA timing parameters here and refer to them in other modules.
    
    endpackage
