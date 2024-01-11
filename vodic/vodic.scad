$fn = 64;

//VARS---
//uchyt
diera_r = 3;
stena_hrubka = 2;
//pant
pant_dlzka = 30;
pant_sirka = 15;
pant_hrubka = 10/2;


translate([50, 0, 0])
    uchyt();

pant(3);


//Moduly---
module pant(segmenty) {
    //prava strana
    cube([pant_dlzka, pant_sirka-pant_hrubka, pant_hrubka]);
    for (x = [0:segmenty-1]) {
        if ((-1)^x == -1) { // -1 -> kazde parne opakovanie
            translate([x*(pant_dlzka/segmenty), pant_sirka, pant_hrubka]) {
                rotate([0, 90])
                    cylinder(r=pant_hrubka, h=(pant_dlzka/segmenty)*0.98);
                translate([0, -pant_hrubka*1.01, -pant_hrubka])
                    cube([(pant_dlzka/segmenty)*0.98, pant_hrubka*1.01, pant_hrubka]);
            }
        }
    }
    //lava strana
    translate([0, pant_sirka*3]){
    scale([1, -1]) {
        cube([pant_dlzka, pant_sirka-pant_hrubka, pant_hrubka]);
        for (x = [0:segmenty-1]) {
            if ((-1)^x == 1) { // 1 -> kazde neparne opakovanie
                translate([x*(pant_dlzka/segmenty), pant_sirka, pant_hrubka]) {
                    rotate([0, 90])
                        cylinder(r=pant_hrubka, h=(pant_dlzka/segmenty)*0.98);
                    translate([0, -pant_hrubka*1.01, -pant_hrubka])
                        cube([(pant_dlzka/segmenty)*0.98, pant_hrubka*1.01, pant_hrubka]);
                }
            }
        }
    }
    }
}

module uchyt() {
    difference() {
        cylinder_hollow(r_out=diera_r+2, r_in=diera_r, h=stena_hrubka);
        translate([0, 0, 0.01])
            cylinder(r1=0, r2=diera_r+0.8*2, h=stena_hrubka);
    }
}


//Snippets---
module cylinder_hollow(r_out, r_in, h=1, r1_out, r2_out, r1_in, r2_in, center=false) {
    difference() {
        cylinder(r=r_out, r1=r1_out, r2=r2_out, h=h, center=center);
        translate([0, 0, -0.01])
            cylinder(r=r_in, r1=r1_in, r2=r2_in, h=h+0.03, center=center);
    }
}
