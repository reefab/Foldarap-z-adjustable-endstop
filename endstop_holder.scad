nema_14_hole_spacing = 26;
nema_14_sides = 35;
nema_14_center_mount_dia = 22;

m3_dia = 3;
m3_nut_width = 5.5;
m3_nut_height = 2.4;
m2dot5_dia = 2.5;
clearance = 0.1;

thickness = 3;

endstop_holes_spacing = 10;
endstop_holes_height = 20;
endstop_mount_height = 25;

screw_mount_height = 10;
screw_mount_hole = 5;

translate([50, 0, 0]) endstop_holder();
screw_holder();

module base() {
    difference() {
        translate([0, 0, thickness/2]) cube([nema_14_sides, nema_14_sides, thickness], center=true);
        //center hole
        cylinder(d=nema_14_center_mount_dia, h=thickness);
        // mounting holes
        for(i=[-1,1]) {
            for(j=[-1,1]) {
                translate([i*nema_14_hole_spacing/2, j*nema_14_hole_spacing/2, 0]) cylinder(d=m3_dia + clearance, h=thickness, $fn=25);
            }
        }
    }
}

module endstop_holder() {
    difference() {
        union() {
            base();
            // endstop holder
            translate([-nema_14_sides/2, -nema_14_sides/2, 0]) cube([thickness, nema_14_sides - 10, endstop_mount_height]);
            // holder support
            difference() {
                translate([-nema_14_sides/2, -nema_14_sides/2 + thickness, 0]) rotate([0, 0, -90]) cube([thickness, nema_14_sides - 10, endstop_mount_height]);
                translate([10, -nema_14_sides/2 + thickness * 2, 0]) rotate([45, 0, -90])  cube([thickness* 2, 40, 40]);
            }

        }
        // endstop holes
        for(i=[-1,1])
            translate([-nema_14_sides/2, i*endstop_holes_spacing/2, endstop_holes_height]) rotate([0, 90, 0]) cylinder(d=m2dot5_dia + clearance, h=thickness);
        // cutting the base in half
        translate([nema_14_sides/2, nema_14_sides/2, thickness/2]) rotate([0, 0, 45]) cube([45, 45, thickness], center=true);
    }
}

module screw_holder() {
    difference() {
        base();
        // cutting base in half
        translate([nema_14_sides/2 -5, 0, thickness/2]) cube([nema_14_sides, nema_14_sides, thickness], center=true);
    }
    difference() {
        // adjustement screw holder
        translate([-6, 16, screw_mount_height/2]) rotate([0,0,45])  cube([10, 10, screw_mount_height], center=true);
        // screw shaft
        translate([-6, 16, screw_mount_hole]) rotate([0,90,45])  cylinder(d=m3_dia + clearance, h=10, center=true);
        // nut trap
        translate([-6, 16, screw_mount_hole]) rotate([0,90,45])  # cylinder(d=m3_nut_width, h=m3_nut_height, center=true, $fn=6);
    }
}
