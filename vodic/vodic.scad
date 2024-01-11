$fn = 64;

//vars
diera_r = 3;
stena_hrubka = 2;


uchyt();

module uchyt() {
    difference() {
        cylinder_hollow(r_out=diera_r+2, r_in=diera_r, h=stena_hrubka);
        translate([0, 0, 0.01])
            cylinder(r1=0, r2=diera_r+0.8*2, h=stena_hrubka);
    }
}

//snippets
module cylinder_hollow(r_out, r_in, h=1, r1_out, r2_out, r1_in, r2_in, center=false) {
    difference() {
        cylinder(r=r_out, r1=r1_out, r2=r2_out, h=h, center=center);
        translate([0, 0, -0.01])
            cylinder(r=r_in, r1=r1_in, r2=r2_in, h=h+0.03, center=center);
    }
}