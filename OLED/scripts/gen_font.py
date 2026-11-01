#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
gen_font.py
Generate SystemVerilog font ROMs for SSD1306 OLED (128x64).
Supported font sizes:
  - FONT8:  ASCII 6x8 (1 page), Chinese 16x8 (1 page)
  - FONT16: ASCII 8x16 (2 pages), Chinese 16x16 (2 pages)
  - FONT32: ASCII 16x32 (4 pages), Chinese 32x32 (4 pages)

Chinese characters:
  小 (0x5C0F), 米 (0x7C73), 玻 (0x73BB), 璃 (0x7483), 珠 (0x73E0),
  白 (0x767D), 砂 (0x7802), 糖 (0x7CD6), 细 (0x7EC6), 盐 (0x76D0)
"""

import os
import sys
from PIL import Image, ImageFont, ImageDraw

# Target characters
CHINESE_CHARS = [
    ('小', 0x5C0F),
    ('米', 0x7C73),
    ('玻', 0x73BB),
    ('璃', 0x7483),
    ('珠', 0x73E0),
    ('白', 0x767D),
    ('砂', 0x7802),
    ('糖', 0x7CD6),
    ('细', 0x7EC6),
    ('盐', 0x76D0),
]

# Classic 5x7 ASCII font (ASCII 0x20 to 0x7E, 95 chars)
# Each char has 5 columns. We pad 1 column (0x00) on the right for 6x8.
# Vertical byte format: bit 0 = top, bit 7 = bottom.
ASCII_5X7 = {
    0x20: [0x00, 0x00, 0x00, 0x00, 0x00], # ' '
    0x21: [0x00, 0x00, 0x5F, 0x00, 0x00], # '!'
    0x22: [0x00, 0x07, 0x00, 0x07, 0x00], # '"'
    0x23: [0x14, 0x7F, 0x14, 0x7F, 0x14], # '#'
    0x24: [0x24, 0x2A, 0x7F, 0x2A, 0x12], # '$'
    0x25: [0x23, 0x13, 0x08, 0x64, 0x62], # '%'
    0x26: [0x36, 0x49, 0x55, 0x22, 0x50], # '&'
    0x27: [0x00, 0x05, 0x03, 0x00, 0x00], # '''
    0x28: [0x00, 0x1C, 0x22, 0x41, 0x00], # '('
    0x29: [0x00, 0x41, 0x22, 0x1C, 0x00], # ')'
    0x2A: [0x14, 0x08, 0x3E, 0x08, 0x14], # '*'
    0x2B: [0x08, 0x08, 0x3E, 0x08, 0x08], # '+'
    0x2C: [0x00, 0x50, 0x30, 0x00, 0x00], # ','
    0x2D: [0x08, 0x08, 0x08, 0x08, 0x08], # '-'
    0x2E: [0x00, 0x60, 0x60, 0x00, 0x00], # '.'
    0x2F: [0x20, 0x10, 0x08, 0x04, 0x02], # '/'
    0x30: [0x3E, 0x51, 0x49, 0x45, 0x3E], # '0'
    0x31: [0x00, 0x42, 0x7F, 0x40, 0x00], # '1'
    0x32: [0x42, 0x61, 0x51, 0x49, 0x46], # '2'
    0x33: [0x21, 0x41, 0x45, 0x4B, 0x31], # '3'
    0x34: [0x18, 0x14, 0x12, 0x7F, 0x10], # '4'
    0x35: [0x27, 0x45, 0x45, 0x45, 0x39], # '5'
    0x36: [0x3C, 0x4A, 0x49, 0x49, 0x30], # '6'
    0x37: [0x01, 0x71, 0x09, 0x05, 0x03], # '7'
    0x38: [0x36, 0x49, 0x49, 0x49, 0x36], # '8'
    0x39: [0x06, 0x49, 0x49, 0x29, 0x1E], # '9'
    0x3A: [0x00, 0x36, 0x36, 0x00, 0x00], # ':'
    0x3B: [0x00, 0x56, 0x36, 0x00, 0x00], # ';'
    0x3C: [0x08, 0x14, 0x22, 0x41, 0x00], # '<'
    0x3D: [0x14, 0x14, 0x14, 0x14, 0x14], # '='
    0x3E: [0x00, 0x41, 0x22, 0x14, 0x08], # '>'
    0x3F: [0x02, 0x01, 0x51, 0x09, 0x06], # '?'
    0x40: [0x32, 0x49, 0x79, 0x41, 0x3E], # '@'
    0x41: [0x7E, 0x11, 0x11, 0x11, 0x7E], # 'A'
    0x42: [0x7F, 0x49, 0x49, 0x49, 0x36], # 'B'
    0x43: [0x3E, 0x41, 0x41, 0x41, 0x22], # 'C'
    0x44: [0x7F, 0x41, 0x41, 0x22, 0x1C], # 'D'
    0x45: [0x7F, 0x49, 0x49, 0x49, 0x41], # 'E'
    0x46: [0x7F, 0x09, 0x09, 0x09, 0x01], # 'F'
    0x47: [0x3E, 0x41, 0x49, 0x49, 0x7A], # 'G'
    0x48: [0x7F, 0x08, 0x08, 0x08, 0x7F], # 'H'
    0x49: [0x00, 0x41, 0x7F, 0x41, 0x00], # 'I'
    0x4A: [0x20, 0x40, 0x41, 0x3F, 0x01], # 'J'
    0x4B: [0x7F, 0x08, 0x14, 0x22, 0x41], # 'K'
    0x4C: [0x7F, 0x40, 0x40, 0x40, 0x40], # 'L'
    0x4D: [0x7F, 0x02, 0x0C, 0x02, 0x7F], # 'M'
    0x4E: [0x7F, 0x04, 0x08, 0x10, 0x7F], # 'N'
    0x4F: [0x3E, 0x41, 0x41, 0x41, 0x3E], # 'O'
    0x50: [0x7F, 0x09, 0x09, 0x09, 0x06], # 'P'
    0x51: [0x3E, 0x41, 0x51, 0x21, 0x5E], # 'Q'
    0x52: [0x7F, 0x09, 0x19, 0x29, 0x46], # 'R'
    0x53: [0x46, 0x49, 0x49, 0x49, 0x31], # 'S'
    0x54: [0x01, 0x01, 0x7F, 0x01, 0x01], # 'T'
    0x55: [0x3F, 0x40, 0x40, 0x40, 0x3F], # 'U'
    0x56: [0x1F, 0x20, 0x40, 0x20, 0x1F], # 'V'
    0x57: [0x3F, 0x40, 0x38, 0x40, 0x3F], # 'W'
    0x58: [0x63, 0x14, 0x08, 0x14, 0x63], # 'X'
    0x59: [0x07, 0x08, 0x70, 0x08, 0x07], # 'Y'
    0x5A: [0x61, 0x51, 0x49, 0x45, 0x43], # 'Z'
    0x5B: [0x00, 0x7F, 0x41, 0x41, 0x00], # '['
    0x5C: [0x02, 0x04, 0x08, 0x10, 0x20], # '\'
    0x5D: [0x00, 0x41, 0x41, 0x7F, 0x00], # ']'
    0x5E: [0x04, 0x02, 0x01, 0x02, 0x04], # '^'
    0x5F: [0x40, 0x40, 0x40, 0x40, 0x40], # '_'
    0x60: [0x00, 0x01, 0x02, 0x04, 0x00], # '`'
    0x61: [0x20, 0x54, 0x54, 0x54, 0x78], # 'a'
    0x62: [0x7F, 0x48, 0x44, 0x44, 0x38], # 'b'
    0x63: [0x38, 0x44, 0x44, 0x44, 0x20], # 'c'
    0x64: [0x38, 0x44, 0x44, 0x48, 0x7F], # 'd'
    0x65: [0x38, 0x54, 0x54, 0x54, 0x18], # 'e'
    0x66: [0x08, 0x7E, 0x09, 0x01, 0x02], # 'f'
    0x67: [0x0C, 0x52, 0x52, 0x52, 0x3E], # 'g'
    0x68: [0x7F, 0x08, 0x04, 0x04, 0x78], # 'h'
    0x69: [0x00, 0x44, 0x7D, 0x40, 0x00], # 'i'
    0x6A: [0x20, 0x40, 0x44, 0x3D, 0x00], # 'j'
    0x6B: [0x7F, 0x10, 0x28, 0x44, 0x00], # 'k'
    0x6C: [0x00, 0x41, 0x7F, 0x40, 0x00], # 'l'
    0x6D: [0x7C, 0x04, 0x18, 0x04, 0x78], # 'm'
    0x6E: [0x7C, 0x08, 0x04, 0x04, 0x78], # 'n'
    0x6F: [0x38, 0x44, 0x44, 0x44, 0x38], # 'o'
    0x70: [0x7C, 0x14, 0x14, 0x14, 0x08], # 'p'
    0x71: [0x08, 0x14, 0x14, 0x18, 0x7C], # 'q'
    0x72: [0x7C, 0x08, 0x04, 0x04, 0x08], # 'r'
    0x73: [0x48, 0x54, 0x54, 0x54, 0x20], # 's'
    0x74: [0x04, 0x3F, 0x44, 0x40, 0x20], # 't'
    0x75: [0x3C, 0x40, 0x40, 0x20, 0x7C], # 'u'
    0x76: [0x1C, 0x20, 0x40, 0x20, 0x1C], # 'v'
    0x77: [0x3C, 0x40, 0x30, 0x40, 0x3C], # 'w'
    0x78: [0x44, 0x28, 0x10, 0x28, 0x44], # 'x'
    0x79: [0x0C, 0x50, 0x50, 0x50, 0x3C], # 'y'
    0x7A: [0x44, 0x64, 0x54, 0x4C, 0x44], # 'z'
    0x7B: [0x00, 0x08, 0x36, 0x41, 0x00], # '{'
    0x7C: [0x00, 0x00, 0x7F, 0x00, 0x00], # '|'
    0x7D: [0x00, 0x41, 0x36, 0x08, 0x00], # '}'
    0x7E: [0x10, 0x08, 0x08, 0x10, 0x08]  # '~'
}

def render_bitmap(text, font_path, font_size, width, height):
    """Render a character onto a 1-bit bitmap of (width, height)"""
    font = ImageFont.truetype(font_path, font_size)
    img = Image.new('1', (width, height), 0)
    draw = ImageDraw.Draw(img)
    # Calculate bounding box to center if needed
    bbox = font.getbbox(text)
    # print bbox for debug
    x_offset = max(0, (width - (bbox[2] - bbox[0])) // 2) if bbox else 0
    y_offset = 0
    draw.text((x_offset, y_offset), text, font=font, fill=1)
    return img

def bitmap_to_vertical_pages(img, width, height):
    """
    Convert (width, height) 1-bit image to SSD1306 vertical page format.
    Returns: list of pages, where each page is a list of 'width' bytes.
    Each byte: bit 0 = top pixel of that page, bit 7 = bottom pixel.
    """
    num_pages = height // 8
    pages = []
    for p in range(num_pages):
        page_bytes = []
        y_start = p * 8
        for x in range(width):
            col_val = 0
            for b in range(8):
                y = y_start + b
                if y < height and img.getpixel((x, y)):
                    col_val |= (1 << b)
            page_bytes.append(col_val)
        pages.append(page_bytes)
    return pages

def gen_font8():
    """
    Generate font_rom_8.sv
    ASCII: 6x8 (95 chars)
    Chinese: 16x8 (10 chars, rendered/downsampled from 16x16)
    """
    print("Generating font_rom_8.sv...")
    simsun_path = 'C:/Windows/Fonts/simsun.ttc'

    # Chinese 16x8: render at 16x16 then scale down vertically to 16x8
    chinese_data = {}
    for ch, code in CHINESE_CHARS:
        img16 = Image.new('1', (16, 16), 0)
        draw = ImageDraw.Draw(img16)
        font = ImageFont.truetype(simsun_path, 16)
        draw.text((0, 0), ch, font=font, fill=1)
        img8 = img16.resize((16, 8), Image.Resampling.NEAREST)
        pages = bitmap_to_vertical_pages(img8, 16, 8)
        chinese_data[code] = (ch, pages[0]) # 16 bytes

    code_lines = []
    code_lines.append("// ================================================================")
    code_lines.append("// font_rom_8.sv - FONT8 Dot Matrix ROM (ASCII 6x8 + Chinese 16x8)")
    code_lines.append("// Generated automatically by scripts/gen_font.py")
    code_lines.append("// ================================================================")
    code_lines.append("`timescale 1ns / 1ps\n")
    code_lines.append("module font_rom_8 (")
    code_lines.append("    input  logic        clk,")
    code_lines.append("    input  logic [15:0] i_char,      // ASCII: 0x0020..0x007E, Chinese: Unicode")
    code_lines.append("    input  logic [3:0]  i_col_idx,   // 0..5 (ASCII) or 0..15 (Chinese)")
    code_lines.append("    output logic [7:0]  o_dot_data,  // 8 vertical pixels (bit0=top)")
    code_lines.append("    output logic [4:0]  o_char_width // Width: 6 (ASCII), 16 (Chinese)")
    code_lines.append(");")
    code_lines.append("")
    code_lines.append("    logic [7:0] dot_reg;")
    code_lines.append("    logic [4:0] width_reg;")
    code_lines.append("")
    code_lines.append("    always_ff @(posedge clk) begin")
    code_lines.append("        dot_reg <= 8'h00;")
    code_lines.append("        width_reg <= 5'd6;")
    code_lines.append("        case (i_char)")

    # ASCII 0x20 to 0x7E
    for ascii_code in range(0x20, 0x7F):
        cols = ASCII_5X7.get(ascii_code, [0, 0, 0, 0, 0]) + [0x00] # 6 cols
        ch_char = chr(ascii_code)
        if ch_char == '\\':
            ch_desc = "'\\\\'"
        elif ch_char == "'":
            ch_desc = "'\\''"
        else:
            ch_desc = f"'{ch_char}'"
        code_lines.append(f"            16'h{ascii_code:04X}: begin // ASCII {ch_desc}")
        code_lines.append("                width_reg <= 5'd6;")
        code_lines.append("                case (i_col_idx)")
        for idx in range(6):
            code_lines.append(f"                    4'd{idx}: dot_reg <= 8'h{cols[idx]:02X};")
        code_lines.append("                    default: dot_reg <= 8'h00;")
        code_lines.append("                endcase")
        code_lines.append("            end")

    # Chinese
    for code, (ch, cols) in chinese_data.items():
        code_lines.append(f"            16'h{code:04X}: begin // Chinese '{ch}'")
        code_lines.append("                width_reg <= 5'd16;")
        code_lines.append("                case (i_col_idx)")
        for idx in range(16):
            code_lines.append(f"                    4'd{idx}: dot_reg <= 8'h{cols[idx]:02X};")
        code_lines.append("                    default: dot_reg <= 8'h00;")
        code_lines.append("                endcase")
        code_lines.append("            end")

    code_lines.append("            default: begin")
    code_lines.append("                dot_reg <= 8'h00;")
    code_lines.append("                width_reg <= 5'd6;")
    code_lines.append("            end")
    code_lines.append("        endcase")
    code_lines.append("    end")
    code_lines.append("")
    code_lines.append("    assign o_dot_data   = dot_reg;")
    code_lines.append("    assign o_char_width = width_reg;")
    code_lines.append("endmodule\n")

    return "\n".join(code_lines)

def gen_font16():
    """
    Generate font_rom_16.sv
    ASCII: 8x16 (2 pages)
    Chinese: 16x16 (2 pages)
    """
    print("Generating font_rom_16.sv...")
    simsun_path = 'C:/Windows/Fonts/simsun.ttc'
    consola_path = 'C:/Windows/Fonts/consola.ttf'

    # ASCII 8x16
    ascii_data = {}
    font_ascii = ImageFont.truetype(consola_path, 15)
    for ascii_code in range(0x20, 0x7F):
        ch = chr(ascii_code)
        img = Image.new('1', (8, 16), 0)
        draw = ImageDraw.Draw(img)
        draw.text((0, 0), ch, font=font_ascii, fill=1)
        pages = bitmap_to_vertical_pages(img, 8, 16)
        ascii_data[ascii_code] = pages # [page0 (8 bytes), page1 (8 bytes)]

    # Chinese 16x16
    chinese_data = {}
    font_cn = ImageFont.truetype(simsun_path, 16)
    for ch, code in CHINESE_CHARS:
        img = Image.new('1', (16, 16), 0)
        draw = ImageDraw.Draw(img)
        draw.text((0, 0), ch, font=font_cn, fill=1)
        pages = bitmap_to_vertical_pages(img, 16, 16)
        chinese_data[code] = (ch, pages) # [page0 (16 bytes), page1 (16 bytes)]

    code_lines = []
    code_lines.append("// ================================================================")
    code_lines.append("// font_rom_16.sv - FONT16 Dot Matrix ROM (ASCII 8x16 + Chinese 16x16)")
    code_lines.append("// Generated automatically by scripts/gen_font.py")
    code_lines.append("// ================================================================")
    code_lines.append("`timescale 1ns / 1ps\n")
    code_lines.append("module font_rom_16 (")
    code_lines.append("    input  logic        clk,")
    code_lines.append("    input  logic [15:0] i_char,      // ASCII: 0x0020..0x007E, Chinese: Unicode")
    code_lines.append("    input  logic        i_page_idx,  // 0: top page (rows 0..7), 1: bottom page (rows 8..15)")
    code_lines.append("    input  logic [3:0]  i_col_idx,   // 0..7 (ASCII) or 0..15 (Chinese)")
    code_lines.append("    output logic [7:0]  o_dot_data,  // 8 vertical pixels (bit0=top)")
    code_lines.append("    output logic [4:0]  o_char_width // Width: 8 (ASCII), 16 (Chinese)")
    code_lines.append(");")
    code_lines.append("")
    code_lines.append("    logic [7:0] dot_reg;")
    code_lines.append("    logic [4:0] width_reg;")
    code_lines.append("")
    code_lines.append("    always_ff @(posedge clk) begin")
    code_lines.append("        dot_reg <= 8'h00;")
    code_lines.append("        width_reg <= 5'd8;")
    code_lines.append("        case (i_char)")

    # ASCII 0x20 to 0x7E
    for ascii_code in range(0x20, 0x7F):
        pages = ascii_data[ascii_code]
        ch_char = chr(ascii_code)
        if ch_char == '\\':
            ch_desc = "'\\\\'"
        elif ch_char == "'":
            ch_desc = "'\\''"
        else:
            ch_desc = f"'{ch_char}'"
        code_lines.append(f"            16'h{ascii_code:04X}: begin // ASCII {ch_desc}")
        code_lines.append("                width_reg <= 5'd8;")
        code_lines.append("                if (!i_page_idx) begin // Top page")
        code_lines.append("                    case (i_col_idx)")
        for idx in range(8):
            code_lines.append(f"                        4'd{idx}: dot_reg <= 8'h{pages[0][idx]:02X};")
        code_lines.append("                        default: dot_reg <= 8'h00;")
        code_lines.append("                    endcase")
        code_lines.append("                end else begin // Bottom page")
        code_lines.append("                    case (i_col_idx)")
        for idx in range(8):
            code_lines.append(f"                        4'd{idx}: dot_reg <= 8'h{pages[1][idx]:02X};")
        code_lines.append("                        default: dot_reg <= 8'h00;")
        code_lines.append("                    endcase")
        code_lines.append("                end")
        code_lines.append("            end")

    # Chinese
    for code, (ch, pages) in chinese_data.items():
        code_lines.append(f"            16'h{code:04X}: begin // Chinese '{ch}'")
        code_lines.append("                width_reg <= 5'd16;")
        code_lines.append("                if (!i_page_idx) begin // Top page")
        code_lines.append("                    case (i_col_idx)")
        for idx in range(16):
            code_lines.append(f"                        4'd{idx}: dot_reg <= 8'h{pages[0][idx]:02X};")
        code_lines.append("                        default: dot_reg <= 8'h00;")
        code_lines.append("                    endcase")
        code_lines.append("                end else begin // Bottom page")
        code_lines.append("                    case (i_col_idx)")
        for idx in range(16):
            code_lines.append(f"                        4'd{idx}: dot_reg <= 8'h{pages[1][idx]:02X};")
        code_lines.append("                        default: dot_reg <= 8'h00;")
        code_lines.append("                    endcase")
        code_lines.append("                end")
        code_lines.append("            end")

    code_lines.append("            default: begin")
    code_lines.append("                dot_reg <= 8'h00;")
    code_lines.append("                width_reg <= 5'd8;")
    code_lines.append("            end")
    code_lines.append("        endcase")
    code_lines.append("    end")
    code_lines.append("")
    code_lines.append("    assign o_dot_data   = dot_reg;")
    code_lines.append("    assign o_char_width = width_reg;")
    code_lines.append("endmodule\n")

    return "\n".join(code_lines)

def gen_font32():
    """
    Generate font_rom_32.sv
    ASCII: 16x32 (4 pages)
    Chinese: 32x32 (4 pages)
    """
    print("Generating font_rom_32.sv...")
    simsun_path = 'C:/Windows/Fonts/simsun.ttc'
    consola_path = 'C:/Windows/Fonts/consola.ttf'

    # ASCII 16x32
    ascii_data = {}
    font_ascii = ImageFont.truetype(consola_path, 30)
    for ascii_code in range(0x20, 0x7F):
        ch = chr(ascii_code)
        img = Image.new('1', (16, 32), 0)
        draw = ImageDraw.Draw(img)
        draw.text((0, 0), ch, font=font_ascii, fill=1)
        pages = bitmap_to_vertical_pages(img, 16, 32)
        ascii_data[ascii_code] = pages # [p0..p3], each 16 bytes

    # Chinese 32x32
    chinese_data = {}
    font_cn = ImageFont.truetype(simsun_path, 32)
    for ch, code in CHINESE_CHARS:
        img = Image.new('1', (32, 32), 0)
        draw = ImageDraw.Draw(img)
        draw.text((0, 0), ch, font=font_cn, fill=1)
        pages = bitmap_to_vertical_pages(img, 32, 32)
        chinese_data[code] = (ch, pages) # [p0..p3], each 32 bytes

    code_lines = []
    code_lines.append("// ================================================================")
    code_lines.append("// font_rom_32.sv - FONT32 Dot Matrix ROM (ASCII 16x32 + Chinese 32x32)")
    code_lines.append("// Generated automatically by scripts/gen_font.py")
    code_lines.append("// ================================================================")
    code_lines.append("`timescale 1ns / 1ps\n")
    code_lines.append("module font_rom_32 (")
    code_lines.append("    input  logic        clk,")
    code_lines.append("    input  logic [15:0] i_char,      // ASCII: 0x0020..0x007E, Chinese: Unicode")
    code_lines.append("    input  logic [1:0]  i_page_idx,  // 0..3 (4 pages = 32 vertical pixels)")
    code_lines.append("    input  logic [4:0]  i_col_idx,   // 0..15 (ASCII) or 0..31 (Chinese)")
    code_lines.append("    output logic [7:0]  o_dot_data,  // 8 vertical pixels")
    code_lines.append("    output logic [5:0]  o_char_width // Width: 16 (ASCII), 32 (Chinese)")
    code_lines.append(");")
    code_lines.append("")
    code_lines.append("    logic [7:0] dot_reg;")
    code_lines.append("    logic [5:0] width_reg;")
    code_lines.append("")
    code_lines.append("    always_ff @(posedge clk) begin")
    code_lines.append("        dot_reg <= 8'h00;")
    code_lines.append("        width_reg <= 6'd16;")
    code_lines.append("        case (i_char)")

    # ASCII 0x20 to 0x7E
    for ascii_code in range(0x20, 0x7F):
        pages = ascii_data[ascii_code]
        ch_char = chr(ascii_code)
        if ch_char == '\\':
            ch_desc = "'\\\\'"
        elif ch_char == "'":
            ch_desc = "'\\''"
        else:
            ch_desc = f"'{ch_char}'"
        code_lines.append(f"            16'h{ascii_code:04X}: begin // ASCII {ch_desc}")
        code_lines.append("                width_reg <= 6'd16;")
        code_lines.append("                case (i_page_idx)")
        for p in range(4):
            code_lines.append(f"                    2'd{p}: begin")
            code_lines.append("                        case (i_col_idx[3:0])")
            for idx in range(16):
                code_lines.append(f"                            4'd{idx}: dot_reg <= 8'h{pages[p][idx]:02X};")
            code_lines.append("                            default: dot_reg <= 8'h00;")
            code_lines.append("                        endcase")
            code_lines.append("                    end")
        code_lines.append("                endcase")
        code_lines.append("            end")

    # Chinese
    for code, (ch, pages) in chinese_data.items():
        code_lines.append(f"            16'h{code:04X}: begin // Chinese '{ch}'")
        code_lines.append("                width_reg <= 6'd32;")
        code_lines.append("                case (i_page_idx)")
        for p in range(4):
            code_lines.append(f"                    2'd{p}: begin")
            code_lines.append("                        case (i_col_idx)")
            for idx in range(32):
                code_lines.append(f"                            5'd{idx}: dot_reg <= 8'h{pages[p][idx]:02X};")
            code_lines.append("                            default: dot_reg <= 8'h00;")
            code_lines.append("                        endcase")
            code_lines.append("                    end")
        code_lines.append("                endcase")
        code_lines.append("            end")

    code_lines.append("            default: begin")
    code_lines.append("                dot_reg <= 8'h00;")
    code_lines.append("                width_reg <= 6'd16;")
    code_lines.append("            end")
    code_lines.append("        endcase")
    code_lines.append("    end")
    code_lines.append("")
    code_lines.append("    assign o_dot_data   = dot_reg;")
    code_lines.append("    assign o_char_width = width_reg;")
    code_lines.append("endmodule\n")

    return "\n".join(code_lines)

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_dir = os.path.dirname(script_dir)
    rtl_dir = os.path.join(project_dir, 'rtl')
    os.makedirs(rtl_dir, exist_ok=True)

    font8_content = gen_font8()
    with open(os.path.join(rtl_dir, 'font_rom_8.sv'), 'w', encoding='utf-8') as f:
        f.write(font8_content)
    print("Wrote font_rom_8.sv")

    font16_content = gen_font16()
    with open(os.path.join(rtl_dir, 'font_rom_16.sv'), 'w', encoding='utf-8') as f:
        f.write(font16_content)
    print("Wrote font_rom_16.sv")

    font32_content = gen_font32()
    with open(os.path.join(rtl_dir, 'font_rom_32.sv'), 'w', encoding='utf-8') as f:
        f.write(font32_content)
    print("Wrote font_rom_32.sv")

    print("All font ROMs generated successfully!")

if __name__ == '__main__':
    main()
