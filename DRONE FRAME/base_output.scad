// Define 'hole' module
module hole (r,h) {
union() {
    translate([r,0,0]) {
        cylinder(h,r,r,center=true);
    }
    translate([-r,0,0]) {
        cylinder(h,r,r,center=true);
    }
        cube([2*r,2*r,h],center=[0,0,h/2], center=true);
}
}


// Define 'arm' module
// 4 arms attach to the base module on the underside at three points
module arm(l,w,h,e) {
    r = w/4;
    difference() {
        translate([65,0,0]) {
            cube([l,w,h],center=true);
        }
        translate([10,0,0]) {
        for (i=[1:4]) {
            translate([6*r*i,0,0]) {
                hole(r,h+1);
            }
        }
        translate([l-e+10,0,0]){
            cylinder(h*1.1,e,e,center=true);
        }
    }
    }
}


// Define central base module
// Base has 4 holes for standoffs
module base(w,h) {
    cube([w,w,h],center=true);
    translate([12.5,12.5,h/2+1]){
        cylinder(2.5,5,5,center=true);
    }
    translate([12.5,-12.5,h/2+1]){
        cylinder(2.5,5,5,center=true);
    }
    translate([-12.5,12.5,h/2+1]){
        cylinder(2.5,5,5,center=true);
    }
    translate([-12.5,-12.5,h/2+1]){
        cylinder(2.5,5,5,center=true);
    }
}


// Define 'leg' module
// Glued on the underside of the arm module
module leg(w,r1) {
    linear_extrude(w) {
    intersection() {
    square(r1);
    difference() {
    circle(r=r1);
    circle(r=r1-w);
    }
    }
    }
}


// Define 'crown' module
// r1 > r2
// axis - distance between the two axes
module crown(r1,r2,r3,axis,h) {
linear_extrude(height=h, center=true) {
    difference() {
        union() {
            circle(r=r3);
            translate([axis,0,0]) {
                circle(r=0.5*r3);
            }
            polygon(points=[[0,r3],[axis,0.5*r3],[axis,-0.5*r3],[0,-r3]]);
        }
        circle(r=r1);
        translate([axis,0,0]) {
                    circle(r=r2);
        }
    }
}
}




object_height=5;
arm_length=113;

//union(){
//translate([0,0,object_height/2.0]){
//    base(40,object_height);
//}
//
//
//// Arms
//rotate(45){
//    translate([10,0,object_height/2]) {
//        arm(arm_length,15,object_height,10);
//    }
//}
//
//rotate(135){
//    translate([10,0,object_height/2]) {
//        arm(arm_length,15,object_height,10);
//    }
//}
//
//rotate(225){
//    translate([10,0,object_height/2]) {
//        arm(arm_length,15,object_height,10);
//    }
//}
//
//rotate(315){
//    translate([10,0,object_height/2]) {
//        arm(arm_length,15,object_height,10);
//    }
//}
//}






module split_crown_left(r1,r2,r3,axis,h) {
    difference() {
        crown(r1,r2,r3,axis,h);
        translate([0,100/2,0]){
            cube(100,center=true);
        }
    }
}

module split_crown_right(r1,r2,r3,axis,h) {
    difference() {
        crown(r1,r2,r3,axis,h);
        translate([0,-100/2,0]){
            cube(100,center=true);
        }
    }
}

// Top section
//r1=7.06/2;
//r3=10.0;
//axis=9.70;
//
//split_crown_left(r1,4.20/2,r3,axis,2.0);
//
//translate([0,10,0]){
//    split_crown_right(r1,4.20/2,r3,axis,2.0);
//}

// Middle section
//r1=7.06/2;
//r3=10.0;
//axis=9.70;
//h=14.0;
//
//
//split_crown_left(r1,2.1/2,r3,axis,14.0);
//
//translate([0,10,0]){
//    split_crown_right(r1,2.1/2,r3,axis,14.0);
//}


// Bottom section
//r1=7.06/2;
//r3=10.0;
//axis=9.70;
//
//
//split_crown_left(r1,3.5/2,r3,axis,3.2);
//
//translate([0,10,0]){
//    split_crown_right(r1,3.5/2,r3,axis,3.2);
//}
