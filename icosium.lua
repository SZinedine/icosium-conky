-- Icosium Conky Theme
-- Copyright (C) 2021  Zineddine Saibi

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.
--------------------------------------------------------------------------------
--         ______________________________               RAM (37%)
--         |_____________________________|     |-----------------------|   |-----|
--         ______________________________      |                       |   |     |
--    |-|  |  .                          |     |                       |   |     |         CPU: 9%
--    | |  |  .                          |     |                       |   |     |         Memory:   3.43Gib / 11.4GIB
--    | |  |  .                          |     |                       |   |     |           Swap:   203Mib / 10.0Gib
--    | |  |_____________________________|     |                       |   |     |         Uptime: 2d 2h 23m
--    | |                                      |                       |   |     |         Disk Usage
--    | |  ______________________________      |                       |   |     |           root: 31.2Gib / 44.0Gib (70%)
--    | |  |    .                        |     |                       |   |     |           home: 649Gib / 732Gib (88%)
--    | |  |    .                        |     |                       |   |     |         Internet
--    | |  |    .                        |     |                       |   |     |           SSID:      "MyAccessPoint"
--    | |  |_____________________________|     |                       |   |     |           Wifi Signal: 100%
--    | |                                      |                       |   |     |           Local IP   : 192.168.1.10
--    | |  ______________________________      |                       |   |     |           Download:    0B    325Mib
--    |*|  |.                            |     |                       |   |     |           Upload:      0B    44Mib
--    | |  |.                            |     |                       |   |     |         Battery:  97%
--    | |  |.                            |     |                       |   |     |
--    | |  |_____________________________|     |                       |   |     |
--    | |                                      |. . . . . . . . . . . .|   |     |
--    | |  ______________________________      |                       |   |     |
--    | |  |        .                    |     |                       |   |     |
--    | |  |        .                    |     |                       |   |     |
--    | |  |        .                    |     |                       |   |. . .|
--    |_|  |_____________________________|     |_______________________|   |_____|
--    41°C
--------------------------------------------------------------------------------

require 'cairo'

---------- SETTINGS -----------

THEME = "monochrome dark"       -- possible values of THEME: "blue dark" ; "blue light" ; "monochrome dark ; monochrome light"
net_interface = "wlan0"         -- EDIT THIS to match your network interface by executing `ifconfig`. It might be "wlan0", "eth0", "wlp3s0" or something else
number_processes_todisplay = 9  -- number of processes to display under the CPU and RAM/Swap bars
display_cpu_titles = true
display_mem_titles = true
font = "Mono"
public_ip_refresh_rate = 60     -- seconds
-------------------------------


if THEME == "blue dark" then
    -- for dark themes
    color0 = 0xA6A6A6   -- background of widgets
    color1 = 0x5594FF   -- foreground of widgets (main color of progression bars)
    color2 = 0x1D1D1D   -- second color
    color3 = 0xFF9000   -- fireground modifier: warning color
    color4 = 0xFF0000   -- fireground modifier: danger color
    color5 = 0xD1CDD5   -- text color
elseif THEME == "blue light" then
    color0 = 0x252525   -- background of widgets
    color1 = 0x3A83FF   -- foreground of widgets (main color of progression bars)
    color2 = 0x1D1D1D   -- second color
    color3 = 0xFF9000   -- fireground modifier: warning color
    color4 = 0xFF0000   -- fireground modifier: danger color
    color5 = 0x1D1D1D   -- text color
elseif THEME == "monochrome dark" then    -- monochrome dark
    color0 = 0x484848   -- background of widgets
    color1 = 0xDEDEDE   -- foreground of widgets (main color of progression bars)
    color2 = 0x1D1D1D   -- second color
    color3 = color1     -- fireground modifier: warning color
    color4 = 0xFF0000   -- fireground modifier: danger color
    color5 = 0xDEDEDE   -- text color
elseif THEME == "monochrome light" then    -- monochrome dark
    color0 = 0x252525   -- background of widgets
    color1 = 0x151515   -- foreground of widgets (main color of progression bars)
    color2 = 0x1D1D1D   -- second color
    color3 = color1     -- fireground modifier: warning color
    color4 = 0xFF0000   -- fireground modifier: danger color
    color5 = 0x1D1D1D   -- text color
end

general_bg_alpha = 0.2
general_fg_alpha = 0.8
general_bg = color0
general_fg = color1
general_text_color = color5

threshold_warning= 60
threshold_danger= 80
battery_threshold_warning = 40
battery_threshold_danger = 12
color_normal = general_fg
color_warning = color3
color_danger = color4

slim_bar_width = 10
normal_bar_width = 80
thick_bar_width = 190

cpu_tmp_x = 20

cpu_x = cpu_tmp_x + 20
cpu_y = 45
cpu_width = 400
cpu_height = normal_bar_width
cpu_interval = 10
cpu_y0 = cpu_y + cpu_height + cpu_interval
cpu_y1 = cpu_y0 + cpu_height + cpu_interval
cpu_y2 = cpu_y1 + cpu_height + cpu_interval
cpu_y3 = cpu_y2 + cpu_height + cpu_interval

cpu_tmp_y = cpu_y3
cpu_tmp_width = slim_bar_width
cpu_tmp_height = (cpu_height + cpu_interval)*4

mem_width = thick_bar_width
mem_height = (cpu_height + cpu_interval)*4
mem_x = cpu_width + cpu_x + 80
mem_y = cpu_y3
swap_width = normal_bar_width
swap_height = mem_height
swap_x = mem_x+mem_width+10
swap_y = mem_y

cpu_infotext_x = cpu_x + 60
cpu_infotext_y = cpu_y3 + 20
mem_infotext_x = mem_x + 20
mem_infotext_y = cpu_infotext_y

infotext_x = mem_x+(mem_width*2)
infotext_y = cpu_y+20
infotext_interval = 25
infotext_font_size = 16
infotext_lastline = infotext_y      -- keep track on where the last line of infotext

clock_x = infotext_x
clock_y = 550
clock_font_size1 = 99
date_x = clock_x + 20
date_y = clock_y+40
date_font_size = 25

has_battery = conky_parse("${battery_percent}") ~= nil
has_second_battery = conky_parse("${battery_percent BAT1}") ~= nil
public_ip = nil


function conky_main()
    if conky_window == nil then
        return
    elseif general_fg == nil or general_bg == nil then
        print("Icosium Conky: Fatal Error. Please define a theme")
    end
    local cs = cairo_xlib_surface_create(conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width,
                                         conky_window.height)
    cr = cairo_create(cs)

    local updates = tonumber(conky_parse('${updates}'))
    if updates > 5 then
        draw_rectangles()
        draw_text()

        -- check the ip adress every x seconds (check the variable public_ip_refresh_rate)
        if public_ip == nil or public_ip == "None" or (updates%public_ip_refresh_rate) == 0 then
            public_ip = get_public_ip()
        end
    end


    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end


function draw_rectangles()
    draw_vertical_rectangle(cpu_tmp_x, cpu_tmp_y, slim_bar_width, cpu_tmp_height, "acpitemp", 100)     -- cpu temperature
    draw_horizontal_rectangle(cpu_x, cpu_y, cpu_width, slim_bar_width, "cpu", 100)      -- total CPU usage
    draw_horizontal_rectangle(cpu_x, cpu_y0, cpu_width, cpu_height, "cpu cpu1", 100)    -- first CPU core usage
    draw_horizontal_rectangle(cpu_x, cpu_y1, cpu_width, cpu_height, "cpu cpu2", 100)
    draw_horizontal_rectangle(cpu_x, cpu_y2, cpu_width, cpu_height, "cpu cpu3", 100)
    draw_horizontal_rectangle(cpu_x, cpu_y3, cpu_width, cpu_height, "cpu cpu4", 100)
    draw_vertical_rectangle(mem_x, mem_y, mem_width, mem_height, "memperc", 100)        -- RAM bar
    draw_vertical_rectangle(swap_x, swap_y, swap_width, swap_height, "swapperc", 100)   -- Swap bar
end


function draw_text()
    write_list_proccesses_cpu(cpu_infotext_x, cpu_infotext_y, 20, general_text_color, 12)    -- processes by cpu... under CPU bars
    write_list_proccesses_mem(mem_infotext_x, mem_infotext_y, 20, general_text_color, 12)    -- processes by RAM... under RAM bars
    write(cpu_tmp_x-5, cpu_tmp_y+15, parse("acpitemp") .. "°C", general_text_color, 12)      -- under the temperature bar
    write_info(infotext_x, infotext_y, infotext_interval, general_text_color, infotext_font_size)    -- general infos on the right of the screen
    write(clock_x, clock_y, string.format("%s:%s", parse("time %H"), parse("time %M")), general_text_color, clock_font_size1)  -- time
    write(date_x, date_y, string.format("%s, %s %s, %s", parse("time %a"), parse("time %b"), parse("time %d"), parse("time %Y")), general_text_color, date_font_size)  -- date
    if display_cpu_titles then write_cpu_titles() end
    if display_mem_titles then write_mem_titles() end
end


function write_info(x, y, interval, color, font_size)
    -- fetch important system info and display them line by line

    local function discharging_battery()
        -- check if the battery is discharging or not
        local bat0 = parse("battery BAT0")
        local bat1 = parse("battery BAT1")
        if has_battery == false then return false end
        if bat0 ~= nil and string.match(bat0, "discharging") then return true end
        if bat1 ~= nil and string.match(bat1, "discharging") then return true end
        return false
    end

    local function draw_battery_textinfo(x, y)
        -- a colored battery indicator
        local batperc_num = tonumber(parse("battery_percent"))
        if has_second_battery then
            batperc_num = math.floor((batperc_num + tonumber(parse("battery_percent BAT1")))/2)
        end

        local batperc_color = color
        if batperc_num >= 40 then
            batperc_color = color
        elseif batperc_num >= 20 then
            batperc_color = color_warning
        elseif batperc_num >= 0 then
            batperc_color = color_danger
        end

        local str = string.format("Battery: %s%s", batperc_num, "%")
        if (discharging_battery()) then
            str = str .. " (discharging)"
        end
        write(x, y, str, batperc_color, font_size)
    end


    local textinfo_str = {
        string.format("CPU:     %s%s", parse("cpu"), "%"),
        string.format("Memory:  %s / %s", parse("mem"), parse("memmax")),
        string.format("  Swap:  %s / %s", parse("swap"), parse("swapmax")),
        string.format("Uptime:  %s", parse("uptime")),

        "Disk Usage",
        string.format("  root:  %s / %s  (%s%s)", parse("fs_used /"), parse("fs_size /"), parse("fs_used_perc /"), "%"),
        string.format("  home:  %s / %s  (%s%s)", parse("fs_used /home"), parse("fs_size /home"), parse("fs_used_perc /home"), "%"),

        "Internet",
        string.format("  SSID:        \"%s\"", parse("wireless_essid " .. net_interface)),
        string.format("  Wifi Signal: %s%s", parse("wireless_link_qual_perc " .. net_interface), "%"),
        string.format("  Public IP:   %s", public_ip),
        string.format("  Local IP:    %s", parse("addr " .. net_interface)),
        string.format("  Download:    %s    %s", parse("downspeed " .. net_interface), parse("totaldown " .. net_interface)),
        string.format("  Upload:      %s    %s", parse("upspeed " .. net_interface), parse("totalup " .. net_interface)),
    }

    local yy = y + interval
    for i in pairs(textinfo_str) do
        write(x, yy, textinfo_str[i], color, font_size)
        yy = yy + interval
    end

    if has_battery then
        draw_battery_textinfo(x, yy)
    end
end


function write_cpu_titles()
    local c0 = "cpu " .. parse("cpu") .. "%"
    local c1 = "cpu1 " .. parse("cpu cpu1") .. "%"
    local c2 = "cpu2 " .. parse("cpu cpu2") .. "%"
    local c3 = "cpu3 " .. parse("cpu cpu3") .. "%"
    local c4 = "cpu4 " .. parse("cpu cpu4") .. "%"
    local x = cpu_x + cpu_width + 2
    local fntsz = 11
    write(x, cpu_y, c0, general_text_color, fntsz)
    write(x, cpu_y0 - (cpu_width/10), c1, general_text_color, fntsz)
    write(x, cpu_y1 - (cpu_width/10), c2, general_text_color, fntsz)
    write(x, cpu_y2 - (cpu_width/10), c3, general_text_color, fntsz)
    write(x, cpu_y3 - (cpu_width/10), c4, general_text_color, fntsz)
end


function write_mem_titles()
    local x = (mem_width/2) + mem_x-20
    local x2 = (swap_width/2) + swap_x-30
    local y = 40

    local str_mem = string.format("RAM (%s%s)", parse("memperc"), "%")
    local str_swap = string.format("Swap (%s%s)", parse("swapperc"), "%")

    write(x, y, str_mem, general_text_color, 12)
    write(x2 ,y, str_swap, general_text_color, 12)
end


function draw_vertical_rectangle(x, y, w, h, toparse, max_value)
    local value = tonumber(parse(toparse))
    local color_current = get_color_from_perc(value)

    cairo_set_source_rgba(cr, rgb_to_r_g_b(general_bg, general_bg_alpha))
    cairo_rectangle(cr, x, y, w, -h)
    cairo_fill(cr)

    cairo_set_source_rgba(cr, rgb_to_r_g_b(color_current, general_fg_alpha))
    local scale = h / max_value
    local indic = scale * value

    cairo_rectangle(cr, x, y, w, -indic)
    cairo_fill(cr)
end


function draw_horizontal_rectangle(x, y, w, h, toparse, max_value)

    local val_str = parse(toparse)
    local value = tonumber(val_str)
    local color_current = get_color_from_perc(value)

    cairo_set_source_rgba(cr, rgb_to_r_g_b(general_bg, general_bg_alpha))
    cairo_rectangle(cr, x, y, w, -h)
    cairo_fill(cr)

    local scale = w / max_value
    local indic = scale * value
    cairo_set_source_rgba(cr, rgb_to_r_g_b(color_current, general_fg_alpha))
    cairo_rectangle(cr, x, y, indic, -h)
    cairo_fill(cr)
end


function write(x, y, text, color, font_size)
    local font_slant = CAIRO_FONT_SLANT_NORMAL
    local font_face = CAIRO_FONT_WEIGHT_NORMAL

    cairo_select_font_face (cr, font, font_slant, font_face);
    cairo_set_font_size (cr, font_size)
    cairo_set_source_rgba (cr, rgb_to_r_g_b(color, 1))
    cairo_move_to (cr, x, y)
    cairo_show_text (cr, text)
    cairo_stroke (cr)
end


function getProcessN(n)
    local name = parse("top name " .. n)
    local value = parse("top cpu " .. n)
    return name .. "              " .. value .. "%"
end


function getMemoryN(n)
    local name = parse("top_mem name " .. n)
    local value = parse("top_mem mem_res " .. n)
    return name .. "          " .. value
end


function write_list_proccesses_cpu(x, y, interval, color, font_size)
    local yy = y+interval
    for i = 1, number_processes_todisplay do
        write(x, yy, getProcessN(i), color, font_size)
        yy = yy + interval
    end
end


function write_list_proccesses_mem(x, y, interval, color, font_size)
    local yy = y+interval
    for i = 1, number_processes_todisplay do
        write(x, yy, getMemoryN(i), color, font_size)
        yy = yy + interval
    end
end


function get_public_ip()
    local po = io.popen("wget http://ipinfo.io/ip -qO -")
    local content = po:read("*a")
    if content == "" or content == nil then
        return "None"
    else
        return content
    end
end


function parse(str)
    -- convinience function
    return conky_parse(string.format("${%s}", str))
end


function get_color_from_perc(perc)
    -- return a color according to the provided value
    local color_current = color_normal

    if perc > threshold_danger then
        color_current = color_danger
    elseif perc > threshold_warning then
        color_current = color_warning
    end

    return color_current
end


function rgb_to_r_g_b(colour, alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
