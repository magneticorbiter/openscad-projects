$fn = 8;

//VARS---
//uchyt
diera_r = 3;
stena_hrubka = 2;
diera_l = 15;
//pant
pant_dlzka = 30;
pant_sirka = 15;
pant_hrubka = 10/2;


translate([250, 0, 0])
    uchyt();
translate([200, 0, 0])
    pant(3);


demo_tvaru1(sirka = 20, stlpce = 3, uhol = 30, rady=10);

//Moduly---
module pant(segmenty) {
    let(segment_pocet = pant_dlzka/segmenty) {
        //prava strana
        cube([pant_dlzka, pant_sirka-pant_hrubka, pant_hrubka]);
        for (x = [0:segmenty-1]) {
            if ((-1)^x == -1) { // -1 -> kazde parne opakovanie
                translate([x*(segment_pocet), pant_sirka, pant_hrubka]) {
                    rotate([0, 90])
                        cylinder(r=pant_hrubka, h=(segment_pocet)*0.98);
                    translate([0, -pant_hrubka*1.01, -pant_hrubka])
                        cube([(segment_pocet)*0.98, pant_hrubka*1.01, pant_hrubka]);
                }
            }
        }
        //lava strana
        translate([0, pant_sirka*3]){
        scale([1, -1]) {
            cube([pant_dlzka, pant_sirka-pant_hrubka, pant_hrubka]);
            for (x = [0:segmenty-1]) {
                if ((-1)^x == 1) { // 1 -> kazde neparne opakovanie
                    translate([x*(segment_pocet), pant_sirka, pant_hrubka]) {
                        rotate([0, 90])
                            cylinder(r=pant_hrubka, h=(segment_pocet)*0.98);
                        translate([0, -pant_hrubka*1.01, -pant_hrubka])
                            cube([(segment_pocet)*0.98, pant_hrubka*1.01, pant_hrubka]);
                    }
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

module demo_tvaru1(sirka, stlpce, uhol, rady) {
    let (dlzka = sirka * 2 * stlpce) {
        for (i = [0:rady-1]) {
            translate([0, i*sirka, 0]) {
                rotate([uhol, 0, 0]) {
                    difference() {
                        union() {
                            cube([dlzka, sirka, sirka]);
                            for (j = [1:dlzka/20]) {
                                translate([j*sirka - sirka/2, sirka/2, sirka]) {
                                    translate([0, 0, 1]) {
                                        rotate([180, 0, 0])
                                            uchyt();
                                    }
                                }
                            }
                        }
                        for (k = [1:dlzka/20]) {
                            translate([k*sirka - sirka/2, sirka/2, sirka-15])
                            union() {
                                cylinder(r = diera_r+1, h = diera_l-2);
                                translate([0, 0, diera_l-2.01])
                                    cylinder(r1=diera_r+1, r2=diera_r, h=2.1);
                            }
                        }
                    }
                }
            }
        }
        // Prerasta to az do vnutra uchytov... treba bud difference (ako v k-loop) alebo nizsie (mozno spravi skary, lebo teraz to doplna presne)
        cube([dlzka, sirka*(rady - (1-cos(uhol))), sirka*sin(uhol)]);
        
        translate([dlzka*0.1, sirka*(rady - (1-cos(uhol))), 0])
            cylinder_hollow(r_out=10, r_in=8, h=4);
        translate([dlzka*0.9, sirka*(rady - (1-cos(uhol))), 0])
            cylinder_hollow(r_out=10, r_in=8, h=4);
    }
}
