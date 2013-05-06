// Global Parameters

dry_lining_hole_diameter = 100;
dry_lining_thickness = 12;
cable_hole_width = 30;
cable_hole_height = 15;
thickness = 1;
front_overlap = 5;
front_plate_thickness = 2;
rear_overlap = 2;
rear_overlap_thickness = 2;

module modname() {

    difference() {

        // Things that exist
        union() {
            // The overlapping front plate
            cylinder(h = front_plate_thickness, r = dry_lining_hole_diameter/2 + front_overlap);

            // The main body that goes into the hole
            translate(v = [0, 0, front_plate_thickness]) {
                cylinder(h = dry_lining_thickness, r = dry_lining_hole_diameter/2);
            }
            
            // Rear overlap that grips the back of the dry-lining
            translate(v = [0, 0, dry_lining_thickness + front_plate_thickness]) {
                cylinder(h = rear_overlap_thickness, r = dry_lining_hole_diameter/2 + rear_overlap);
            }
        }

        // Things to be cut out
        union() {
            // Make hollow
            translate(v = [0, 0, front_plate_thickness]) {
                cylinder(h = dry_lining_thickness + front_plate_thickness, r = dry_lining_hole_diameter/2 - thickness );
            }

            // Convert rear overlap into just short protrusions
            translate(v = [-dry_lining_hole_diameter/2, dry_lining_hole_diameter * 0.2, dry_lining_thickness + front_plate_thickness]) {
                cube(size = [dry_lining_hole_diameter, dry_lining_hole_diameter/3, rear_overlap_thickness]);
            }
            translate(v = [-dry_lining_hole_diameter/2, -dry_lining_hole_diameter * 0.53, dry_lining_thickness + front_plate_thickness]) {
                cube(size = [dry_lining_hole_diameter, dry_lining_hole_diameter/3, rear_overlap_thickness]);
            }

            // Vertical cut to enable rear overlap to flex
            translate(v = [-dry_lining_hole_diameter/2, dry_lining_hole_diameter * 0.2, front_plate_thickness]) {
                cube(size = [dry_lining_hole_diameter, thickness, dry_lining_thickness + rear_overlap_thickness]);
            }
            translate(v = [-dry_lining_hole_diameter/2, -dry_lining_hole_diameter * 0.2, front_plate_thickness]) {
                cube(size = [dry_lining_hole_diameter, thickness, dry_lining_thickness + rear_overlap_thickness]);
            }

            // Hole for cables
            cube(size = [cable_hole_width, cable_hole_height, front_plate_thickness * 2], center = true);
            translate(v = [cable_hole_width/2, 0, 0]) {
                cylinder(h = front_plate_thickness, r = cable_hole_height/2 );
            }
            translate(v = [-cable_hole_width/2, 0, 0]) {
                cylinder(h = front_plate_thickness, r = cable_hole_height/2 );
            }
        }
    }

}

modname();
