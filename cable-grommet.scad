// Global Parameters
// chrisjrob

grommet_hole_diameter = 80;
grommet_depth = 12.75;
cable_hole_width = 30;
cable_hole_height = 15;
thickness = 1;
top_plate_overlap = 5;
top_plate_thickness = 2;
bottom_overlap = 2;
bottom_overlap_thickness = 2;

module modname() {

    difference() {

        // Things that exist
        union() {
            // The overlapping front plate
            cylinder(h = top_plate_thickness, r = grommet_hole_diameter/2 + top_plate_overlap);

            // The main body that goes into the hole
            translate(v = [0, 0, top_plate_thickness]) {
                cylinder(h = grommet_depth, r = grommet_hole_diameter/2);
            }
            
            // Rear overlap cylinder (not required if sphere works)
            translate(v = [0, 0, top_plate_thickness + grommet_depth]) {
                cylinder(h = bottom_overlap_thickness, r = grommet_hole_diameter/2 + bottom_overlap - thickness);
            }

            // Rear overlap that grips the back of the dry-lining
            translate(v = [0, 0, top_plate_thickness + grommet_depth]) {
                difference() {
                    sphere(r = grommet_hole_diameter/2 + bottom_overlap);
                    sphere(r = grommet_hole_diameter/2 + bottom_overlap - thickness);
                }
            }

        }

        // Things to be cut out
        union() {

            // Remove around bottom of sphere
            translate(v = [0, 0, top_plate_thickness]) {
                difference() {
                    cylinder(h = grommet_depth, r = (grommet_hole_diameter/2 + bottom_overlap + thickness));
                    cylinder(h = grommet_depth, r = grommet_hole_diameter/2);
                }
            }

            // Remove bottom of sphere
            translate(v = [0, 0, (-1 * grommet_hole_diameter/2)]) {
                cube( size = [grommet_hole_diameter + grommet_depth, grommet_hole_diameter + grommet_depth, grommet_hole_diameter], center = true);
            }

            // Remove top of sphere
            translate(v = [(grommet_hole_diameter + grommet_depth)/-2, (grommet_hole_diameter + grommet_depth)/-2, top_plate_thickness + (grommet_depth * 2)]) {
                cube( size = [grommet_hole_diameter + grommet_depth, grommet_hole_diameter + grommet_depth, grommet_hole_diameter/2]);
            }

            // Make hollow
            translate(v = [0, 0, top_plate_thickness]) {
                cylinder(h = grommet_depth + top_plate_thickness, r = grommet_hole_diameter/2 - thickness );
            }

            // Convert rear overlap into just short protrusions
            translate(v = [-grommet_hole_diameter, grommet_hole_diameter * 0.2, grommet_depth + top_plate_thickness]) {
                cube(size = [grommet_hole_diameter * 2, grommet_hole_diameter * 0.6, grommet_depth * 2]);
            }
            translate(v = [-grommet_hole_diameter, -grommet_hole_diameter * 0.59, grommet_depth + top_plate_thickness]) {
                cube(size = [grommet_hole_diameter * 2, grommet_hole_diameter * 0.4, grommet_depth * 2]);
            }

            // Vertical cut to enable rear overlap to flex
            translate(v = [-grommet_hole_diameter/2, grommet_hole_diameter * 0.2, top_plate_thickness]) {
                cube(size = [grommet_hole_diameter, 1, grommet_depth + bottom_overlap_thickness]);
            }
            translate(v = [-grommet_hole_diameter/2, -grommet_hole_diameter * 0.2, top_plate_thickness]) {
                cube(size = [grommet_hole_diameter, 1, grommet_depth + bottom_overlap_thickness]);
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

modname();
