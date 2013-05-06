// Cable Grommet for Desk or Dry-lining
// by chrisjrob

// Global Parameters
grommet_hole_diameter = 80;   // Size of the hole
grommet_depth = 12.75;        // Thickness of dry-lining, desk or whatever
cable_hole_diameter = 20;     // Size of the small hole through which the cables travel
thickness = 1;                // General thickness of items not specified elsewhere
cap_overlap = 7.5;            // How much overlap you would like around the hole in the desk or dry-lining
cap_thickness = 1;            // How thick you would like the front or top of the grommet
bottom_overlap = 3;           // How much you want the clips to overlap the hole
bottom_overlap_angle = 60;    // Angle of clip - you may not be able to print much more than 45
number_of_clips = 4;          // 0 if you can rely on gravity, 2 for a wall or 4 for ceiling?
spacing = 0.4;                // Gap you want between the barrel of the cap and the barrel of the grommet

module cap() {

    difference() {

        // Things that exist
        union() {

            // The overlapping front plate
            cylinder(h = cap_thickness, r = grommet_hole_diameter/2 + cap_overlap/2, $fn=200);

            // Barrel of cap
            rotate_extrude($fn=200)
                translate([grommet_hole_diameter/2 - thickness - spacing,cap_thickness,0])
                    polygon(points = [ [-thickness,0], [-thickness,grommet_depth], [0,grommet_depth], [0,0] ], paths = [ [0,1,2,3,0] ]);

            // Barrel of the cable hole
            rotate_extrude($fn=200)
                translate([cable_hole_diameter/2+thickness,cap_thickness,0])
                   polygon(points = [ [-thickness,0], [-thickness,grommet_depth], [0,grommet_depth], [0,0] ], paths = [ [0,1,2,3,0] ]);

            // The sides between the cable hole and the barrel of cap
            translate([cable_hole_diameter/2,-thickness,cap_thickness])
                cube([grommet_hole_diameter/2 - cable_hole_diameter/2 -thickness - spacing,thickness * 2,grommet_depth]);
            translate([-grommet_hole_diameter/2 +thickness + spacing,-thickness,cap_thickness])
                cube([grommet_hole_diameter/2 - cable_hole_diameter/2 -thickness - spacing,thickness * 2,grommet_depth]);
        }

        // Things that don't exist
        union() {

            // The dividing cap between each side of the cap
            translate([-grommet_hole_diameter/2 - cap_overlap/2,-spacing/2,0])
                cube([grommet_hole_diameter +cap_overlap,spacing,grommet_depth + cap_thickness]);

            // The hole for the cable in the cap
            cylinder(h = cap_thickness, r = cable_hole_diameter/2, $fn=200);

        }

    }

}

module grommet() {

    difference() {

        // Things that exist
        union() {
            // The overlapping front plate
            cylinder(h = cap_thickness, r = grommet_hole_diameter/2 + cap_overlap, $fn=200);

            rotate_extrude($fn=200)
                translate([grommet_hole_diameter/2 - thickness,cap_thickness,0])
                    polygon(points = [ [0,0], [0,grommet_depth + thickness], [bottom_overlap,grommet_depth + thickness + bottom_overlap * (2-bottom_overlap_angle/45)], [-thickness,grommet_depth * 2], [0,grommet_depth * 2], [bottom_overlap + thickness,grommet_depth + bottom_overlap * (2-bottom_overlap_angle/45)], [thickness,grommet_depth], [thickness,0] ], paths = [ [0,1,2,3,4,5,6,7,0,1] ]);
        }

        // Things to be cut out
        union() {

            // Remove corners
            if (number_of_clips > 2) {
                translate(v = [-grommet_hole_diameter * 0.7+1, grommet_hole_diameter * 0.2, grommet_depth + cap_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter/2, grommet_depth]);
                }
                translate(v = [grommet_hole_diameter * 0.2, grommet_hole_diameter * 0.2, grommet_depth + cap_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter/2, grommet_depth]);
                }
                translate(v = [-grommet_hole_diameter * 0.7+1, -grommet_hole_diameter * 0.7+1, grommet_depth + cap_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter/2, grommet_depth]);
                }
                translate(v = [grommet_hole_diameter * 0.2, -grommet_hole_diameter * 0.7+1, grommet_depth + cap_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter/2, grommet_depth]);
                }
            } else if (number_of_clips > 0) {
                translate(v = [-grommet_hole_diameter * 0.7+1, -grommet_hole_diameter/2, grommet_depth + cap_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter, grommet_depth]);
                }
                translate(v = [grommet_hole_diameter * 0.2, -grommet_hole_diameter/2, grommet_depth + cap_thickness]) {
                    cube(size = [grommet_hole_diameter/2, grommet_hole_diameter, grommet_depth]);
                }
            } else if (number_of_clips <= 0) {
                translate(v = [-grommet_hole_diameter, -grommet_hole_diameter, grommet_depth + cap_thickness]) {
                    cube(size = [grommet_hole_diameter * 2, grommet_hole_diameter * 2, grommet_depth]);
                }
            }

            // Vertical cut to enable rear overlap to flex
            if (number_of_clips > 2) {
                translate(v = [grommet_hole_diameter * 0.2, -grommet_hole_diameter, cap_thickness]) {
                    cube(size = [1, grommet_hole_diameter * 2, grommet_depth * 2]);
                }
                translate(v = [-grommet_hole_diameter * 0.2, -grommet_hole_diameter, cap_thickness]) {
                    cube(size = [1, grommet_hole_diameter * 2, grommet_depth * 2]);
                }
                translate(v = [-grommet_hole_diameter, grommet_hole_diameter * 0.2, cap_thickness]) {
                    cube(size = [grommet_hole_diameter * 2, 1, grommet_depth * 2]);
                }
                translate(v = [-grommet_hole_diameter, -grommet_hole_diameter * 0.2, cap_thickness]) {
                    cube(size = [grommet_hole_diameter * 2, 1, grommet_depth * 2]);
                }
            } else if (number_of_clips > 0) {
                translate(v = [grommet_hole_diameter * 0.2, -grommet_hole_diameter, cap_thickness]) {
                    cube(size = [1, grommet_hole_diameter * 2, grommet_depth * 2]);
                }
                translate(v = [-grommet_hole_diameter * 0.2, -grommet_hole_diameter, cap_thickness]) {
                    cube(size = [1, grommet_hole_diameter * 2, grommet_depth * 2]);
                }
            }

            // Remove centre of cap
            cylinder(h = cap_thickness, r = grommet_hole_diameter/2 - thickness, $fn=100);

        }
    }

}

translate(v = [grommet_hole_diameter/-2 - cap_overlap - 5, 0, 0])
    grommet();

translate(v = [grommet_hole_diameter/2 + cap_overlap + 5, 0, 0])
    cap();
