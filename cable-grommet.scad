// Global Parameters
// chrisjrob

grommet_hole_diameter = 80;
grommet_depth = 12.75;
cable_hole_diameter = 20;
thickness = 2;
top_plate_overlap = 7.5;
top_plate_thickness = 1;
bottom_overlap = 3;
bottom_overlap_thickness = 2;
bottom_overlap_angle = 60;
number_of_clips = 4;
lid_spacing = 1;

module lid() {

    difference() {

        // Things that exist
        union() {

            // The overlapping front plate
            cylinder(h = top_plate_thickness, r = grommet_hole_diameter/2 + top_plate_overlap/2, $fn=200);

            // Barrel of lid
            rotate_extrude($fn=200)
                translate([grommet_hole_diameter/2 -2 - lid_spacing,top_plate_thickness,0])
                    polygon(points = [ [-1,0], [-1,grommet_depth], [0,grommet_depth], [0,0] ], paths = [ [0,1,2,3,0] ]);

            rotate_extrude($fn=200)
                translate([cable_hole_diameter/2+1,top_plate_thickness,0])
                   polygon(points = [ [-1,0], [-1,grommet_depth], [0,grommet_depth], [0,0] ], paths = [ [0,1,2,3,0] ]);

            translate([cable_hole_diameter/2,-1,top_plate_thickness])
                cube([grommet_hole_diameter/2 - cable_hole_diameter/2 -3,2,grommet_depth]);
            translate([-grommet_hole_diameter/2 +3,-1,top_plate_thickness])
                cube([grommet_hole_diameter/2 - cable_hole_diameter/2 -3,2,grommet_depth]);
        }

        // Things that don't exist
        union() {
            translate([-grommet_hole_diameter/2 - top_plate_overlap/2,-0.2,0])
                # cube([grommet_hole_diameter +top_plate_overlap,0.4,grommet_depth + top_plate_thickness]);

            cylinder(h = top_plate_thickness, r = cable_hole_diameter/2, $fn=200);

        }

    }

}

module grommet() {

    difference() {

        // Things that exist
        union() {
            // The overlapping front plate
            cylinder(h = top_plate_thickness, r = grommet_hole_diameter/2 + top_plate_overlap, $fn=200);

            rotate_extrude($fn=200)
                translate([grommet_hole_diameter/2 - thickness,top_plate_thickness,0])
                    polygon(points = [ [0,0], [0,grommet_depth/2], [-1,grommet_depth/2], [-1,grommet_depth/2+1],[0,grommet_depth/2+1], [0,grommet_depth + thickness], [bottom_overlap,grommet_depth + thickness + bottom_overlap * (2-bottom_overlap_angle/45)], [-thickness,grommet_depth * 2], [0,grommet_depth * 2], [bottom_overlap + thickness,grommet_depth + bottom_overlap * (2-bottom_overlap_angle/45)], [thickness,grommet_depth], [thickness,0] ], paths = [ [0,1,2,3,4,5,6,7,8,9,10,11,0,1] ]);
        }

        // Things to be cut out
        union() {

            // Remove corners
            if (number_of_clips > 2) {
                translate(v = [-grommet_hole_diameter * 0.7+1, grommet_hole_diameter * 0.2, grommet_depth + top_plate_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter/2, grommet_depth]);
                }
                translate(v = [grommet_hole_diameter * 0.2, grommet_hole_diameter * 0.2, grommet_depth + top_plate_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter/2, grommet_depth]);
                }
                translate(v = [-grommet_hole_diameter * 0.7+1, -grommet_hole_diameter * 0.7+1, grommet_depth + top_plate_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter/2, grommet_depth]);
                }
                translate(v = [grommet_hole_diameter * 0.2, -grommet_hole_diameter * 0.7+1, grommet_depth + top_plate_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter/2, grommet_depth]);
                }
            } else if (number_of_clips > 0) {
                translate(v = [-grommet_hole_diameter * 0.7+1, -grommet_hole_diameter/2, grommet_depth + top_plate_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter, grommet_depth]);
                }
                translate(v = [grommet_hole_diameter * 0.2, -grommet_hole_diameter/2, grommet_depth + top_plate_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter, grommet_depth]);
                }
            } else if (number_of_clips <= 0) {
                translate(v = [-grommet_hole_diameter, -grommet_hole_diameter, grommet_depth + top_plate_thickness]) {
                    cube(size = [grommet_hole_diameter * 2, grommet_hole_diameter * 2, grommet_depth]);
                }
            }

            // Vertical cut to enable rear overlap to flex
            if (number_of_clips > 2) {
                translate(v = [grommet_hole_diameter * 0.2, -grommet_hole_diameter, top_plate_thickness]) {
                    cube(size = [1, grommet_hole_diameter * 2, grommet_depth * 2]);
                }
                translate(v = [-grommet_hole_diameter * 0.2, -grommet_hole_diameter, top_plate_thickness]) {
                    cube(size = [1, grommet_hole_diameter * 2, grommet_depth * 2]);
                }
                translate(v = [-grommet_hole_diameter, grommet_hole_diameter * 0.2, top_plate_thickness]) {
                    cube(size = [grommet_hole_diameter * 2, 1, grommet_depth * 2]);
                }
                translate(v = [-grommet_hole_diameter, -grommet_hole_diameter * 0.2, top_plate_thickness]) {
                    cube(size = [grommet_hole_diameter * 2, 1, grommet_depth * 2]);
                }
            } else if (number_of_clips > 0) {
                translate(v = [grommet_hole_diameter * 0.2, -grommet_hole_diameter, top_plate_thickness]) {
                    cube(size = [1, grommet_hole_diameter * 2, grommet_depth * 2]);
                }
                translate(v = [-grommet_hole_diameter * 0.2, -grommet_hole_diameter, top_plate_thickness]) {
                    cube(size = [1, grommet_hole_diameter * 2, grommet_depth * 2]);
                }
            }

            // Remove centre of top_plate
            cylinder(h = top_plate_thickness, r = grommet_hole_diameter/2 - thickness * 2, $fn=100);

        }
    }

}

translate(v = [grommet_hole_diameter/-2 - top_plate_overlap - 5, 0, 0])
    grommet();

translate(v = [grommet_hole_diameter/2 + top_plate_overlap + 5, 0, 0])
    lid();
