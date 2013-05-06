// Global Parameters
// chrisjrob

grommet_hole_diameter = 80;
grommet_depth = 12.75;
cable_hole_width = 30;
cable_hole_height = 15;
thickness = 1;
top_plate_overlap = 7.5;
top_plate_thickness = 2;
bottom_overlap = 3;
bottom_overlap_thickness = 2;
bottom_overlap_angle = 60;
number_of_clips = 4;

module grommet() {

    difference() {

        // Things that exist
        union() {
            // The overlapping front plate
            cylinder(h = top_plate_thickness, r = grommet_hole_diameter/2 + top_plate_overlap);

            rotate_extrude()
                translate([grommet_hole_diameter/2 - thickness,top_plate_thickness,0])
                    polygon(points = [ [0,0], [0,grommet_depth + thickness], [bottom_overlap,grommet_depth + thickness + bottom_overlap * (2-bottom_overlap_angle/45)], [-thickness,grommet_depth * 2], [0,grommet_depth * 2], [bottom_overlap + thickness,grommet_depth + bottom_overlap * (2-bottom_overlap_angle/45)], [thickness,grommet_depth], [thickness,0] ], paths = [ [0,1,2,3,4,5,6,7,0,1] ]);
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

            // Hole for cables
            cube(size = [cable_hole_width, cable_hole_height, top_plate_thickness * 2], center = true);
            translate(v = [cable_hole_width/2, 0, 0]) {
                cylinder(h = top_plate_thickness, r = cable_hole_height/2 );
            }
            translate(v = [-cable_hole_width/2, 0, 0]) {
                cylinder(h = top_plate_thickness, r = cable_hole_height/2 );
            }

        }
    }

}

grommet();
