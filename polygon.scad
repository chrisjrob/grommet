// polygon.scad
// Copyright (C) 2013 Christopher Robertsi

    polygon(points = [
                        [0, 0],
                        [0, grommet_depth + thickness * 0.6666],
                        [bottom_overlap - thickness * 1.3333, grommet_depth + thickness * 0.3333 + bottom_overlap * (2-bottom_overlap_angle/45)],
                        [-thickness, grommet_depth * 2],
                        [0, grommet_depth * 2],
                        [bottom_overlap, grommet_depth + bottom_overlap * (2-bottom_overlap_angle/45)],
                        [thickness, grommet_depth],
                        [thickness, 0]
                    ], paths = [ [0,1,2,3,4,5,6,7,0,1] ]);
