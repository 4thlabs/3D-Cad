/**
 * A parametric Knob
 */
 
 innerRayon = 7;
 innerHeight = 5;
 
 screwDiameter = 3.2;
 
 outerDiameter = innerHeight / 1.4;
 
 toothCount = 14;
 
 $fn = 200;

 union() {
    inner();
    outer();
 }
 
 module inner() {
     difference() {
        cylinder(innerHeight, innerRayon, innerRayon, false);
        translate([0, 0, -.5]) cylinder(innerHeight + 1, screwDiameter / 2, screwDiameter / 2, false);
        translate([0, 0, innerHeight - 2.4]) linear_extrude(2.4)  circle(d = 6.1, $fn = 6);
     }
 }
 
 module outer() {
     difference() {
        rotate_extrude(angle = 360, convexity = 10) {
            translate([innerRayon, innerHeight / 2, 0])
                resize([outerDiameter, innerHeight]) circle(d = innerHeight);
        }
        
        cylinder(innerHeight, innerRayon, innerRayon, false);
        
        for (angle = [0 : (360 / toothCount) : 360]) {
            teeth(angle);
        }
    }
 }
 
 module teeth(angle = 90) { 
    rotate(a = angle, v = [0, 0, 1]) 
        translate([innerRayon + (outerDiameter), 0, 0])
            linear_extrude(height = innerHeight, center = false, convexity = 10) {
                resize([innerHeight, innerHeight / 1.5])
                    circle(d = innerHeight);
            }
 }