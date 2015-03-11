nema_14_hole_spacing = 26;
nema_14_sides = 35;
nema_14_center_mount_dia = 22;

m3_dia = 3;
m2dot5_dia = 2.5;
clearance = 0.1;

thickness = 3;

endstop_holes_spacing = 10;
endstop_holes_height = 20;
endstop_mount_height = 25;

endstop_holder();

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
            translate([-nema_14_sides/2, -nema_14_sides/2, 0]) cube([thickness, nema_14_sides, endstop_mount_height]);
        }
        // endstop holes
        for(i=[-1,1])
            translate([-nema_14_sides/2, i*endstop_holes_spacing/2, endstop_holes_height]) rotate([0, 90, 0]) #cylinder(d=m2dot5_dia + clearance, h=thickness);
    }
}
