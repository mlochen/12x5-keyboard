/*
 * Copyright (C) 2019 Marco Lochen
 *
 * This work is licensed under the Creative Commons Attribution 4.0
 * International License. To view a copy of this license, visit
 * http://creativecommons.org/licenses/by/4.0/ or send a letter to Creative
 * Commons, PO Box 1866, Mountain View, CA 94042, USA.
 */

kbx = 228;          // size in x direction
kby = 95;           // size in y direction
bx = 1.8;           // border in x direction
by = 10;            // border in y direction
bh = 9;             // border height
a = 6;              // tilt angle

module base_plate()
{
    difference()
    {
        cube([kbx + 2 * bx, (kby + 2 * by) / cos(a), 1.5]);
        for (x = [0:11])
        {
            for (y = [0:4])
            {
                translate([x * 19 + 9.5 + bx, y * 19 + 9.5 + by, 0]) cube([14, 14, 10], center = true);
            }
        }
    }
}

module bracing()
{
    for (x = [1:11])
    {
        translate([x * 19 + bx - 0.4, -50, 0]) cube([0.8, (kby + 2 * by) / cos(a) + 100, 4]);
    }
    for (y = [1:4])
    {
        translate([-50, y * 19 + by - 0.4, 0]) cube([kbx + 2 * bx + 100, 0.8, 4]);
    }
}

module key_plate()
{
    intersection()
    {
        union()
        {
            base_plate();
            bracing();
        }
        rotate([a, 0, 0]) translate([bx / 2, by / 2, -50]) cube([kbx + bx, kby + by, 100]);
    }
}

module base_border()
{
    difference()
    {
        hull()
        {
            translate([4, 4, 0]) cylinder(h = 100, r = 4, $fn = 16);
            translate([4, kby + 2 * by - 4, 0]) cylinder(h = 100, r = 4, $fn = 16);
            translate([kbx + 2 * bx - 4, 4, 0]) cylinder(h = 100, r = 4, $fn = 16);
            translate([kbx + 2 * bx - 4, kby + 2 * by - 4, 0]) cylinder(h = 100, r = 4, $fn = 16);
        }
        translate([bx, by, -1]) cube([kbx, kby, 102]);
    }
}

module border()
{
    module bolt_cutout(h = 12)
    {
        cylinder(h = kby, r = 1.7, $fn = 16);
        translate([0, 0, -1.5]) cylinder(h = 4, r1 = 4, r2 = 0, $fn = 16);
        translate([0, 2, 1.4 + 3]) cube([5.8, 12, 2.8], center = true);
    }
    
    module wire_cut()
    {
        wire_d = 4.6;
        translate([0, wire_d / 2]) circle(r = wire_d / 2, $fn = 16);
        square([wire_d, wire_d], center = true);
    }
    
    module wire_cutout()
    {
        rotate([90, 0, 0]) linear_extrude(10) wire_cut();
        translate([10, 0, 0]) rotate([0, 0, 45]) rotate_extrude(angle = 135, $fn = 32)
            translate([10, 0]) wire_cut();
        translate([20 / sqrt(2) + 10, 20 / sqrt(2), 0]) rotate([0, 0, 225])
            rotate_extrude(angle = 135, $fn = 32) translate([10, 0]) wire_cut();
    }
        
    difference()
    {
        union()
        {
            base_border();
            translate([50, kby + 2 * by, 0]) difference()
            {
                cylinder(h = 16, r1 = 15, r2 = 10, $fn = 32);
                translate([0, 45, 0]) cube([100, 100, 100], center = true);
            }
        }
        translate([bx + 9.5, by / 2, 0]) bolt_cutout(8);
        translate([bx + 9.5, by + kby + by / 2, 0]) rotate([0, 0, 180]) bolt_cutout();
        translate([bx + kbx / 2 - 9.5, by / 2, 0]) bolt_cutout(8);
        translate([bx + kbx / 2 - 9.5, by + kby + by / 2, 0]) rotate([0, 0, 180]) bolt_cutout();
        translate([bx + kbx / 2 + 9.5, by / 2, 0]) bolt_cutout(8);
        translate([bx + kbx / 2 + 9.5, by + kby + by / 2, 0]) rotate([0, 0, 180]) bolt_cutout();
        translate([bx + kbx - 9.5, by / 2, 0]) bolt_cutout(8);
        translate([bx + kbx - 9.5, by + kby + by / 2, 0]) rotate([0, 0, 180]) bolt_cutout();
        
        translate([40, kby + 2 * by, 0]) mirror([0, 1, 0]) wire_cutout();
        
        translate([24, 2, -1]) cube([30, 6, 6]);
        translate([kbx + 2 * bx - 24 - 30, 2, -1]) cube([30, 6, 6]);
    }
}

module complete()
{
    key_plate();
    
    intersection()
    {
        rotate([a, 0, 0]) translate([0, 0, bh]) mirror([0, 0, 1]) border();
        translate([0, 0, 500]) cube([1000, 1000, 1000], center = true);
    }
}

module half1()
{        
    intersection()
    {
        complete();
        translate([-500 + kbx / 2 + bx, 0, 0]) cube([1000, 1000, 1000], center = true);
    }
}

module half2()
{        
    intersection()
    {
        complete();
        translate([500 + kbx / 2 + bx, 0, 0]) cube([1000, 1000, 1000], center = true);
    }
}

complete();
// for smaller print beds the keyboard can be printed in two halfes and then glued together
//half1();
//half2();
