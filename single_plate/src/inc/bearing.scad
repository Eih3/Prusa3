// PRUSA iteration3
// Bearing holders
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

bearing_diameter = 15;

module horizontal_bearing_base(bearings=1){
 translate(v=[0,0,8/2]) cube(size = [24,8+bearings*25,8], center = true);	
}
module horizontal_bearing_holes(bearings=1){
 cutter_lenght = 10+bearings*25;
 one_holder_lenght = 8+25;
 holder_lenght = 8+bearings*25;
 
 // Main bearing cut
 difference(){
  translate(v=[0,0,12]) rotate(a=[90,0,0]) translate(v=[0,0,-cutter_lenght/2]) cylinder(h = cutter_lenght, r=bearing_diameter/2, $fn=50);
  // Bearing retainers
  translate(v=[0,1-holder_lenght/2,3]) cube(size = [24,6,8], center = true);
  translate(v=[0,-1+holder_lenght/2,3]) cube(size = [24,6,8], center = true);
 }
 
 // Ziptie cutouts
 ziptie_cut_ofset = 0;
 for ( i = [0 : bearings-1] ){
  // For easier positioning I move them by half of one 
  // bearing holder then add each bearign lenght and then center again
  translate(v=[0,-holder_lenght/2,0]) translate(v=[0,one_holder_lenght/2+i*25,0]) difference(){
   union(){
    translate(v=[0,2-6,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = 4, r=12.5, $fn=50);
    translate(v=[0,2+6,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = 4, r=12.5, $fn=50);
   }
   translate(v=[0,10,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = 24, r=10, $fn=50);
  }
 }
 
}

*difference() {
horizontal_bearing_base();
horizontal_bearing_holes();
}

module horizontal_bearing_test(){
 difference(){
  horizontal_bearing_base(1);
  horizontal_bearing_holes(1);
 }
 translate(v=[30,0,0]) difference(){
  horizontal_bearing_base(2);
  horizontal_bearing_holes(2);
 }
 translate(v=[60,0,0]) difference(){
  horizontal_bearing_base(3);
  horizontal_bearing_holes(3);
 }
}


vertical_bearing_height = 50;

thinwall = 2;
bearing_size = bearing_diameter + 2 * thinwall;

module vertical_bearing_base(){
 translate(v=[-2-bearing_size/4,0,vertical_bearing_height/2]) cube(size = [4+bearing_size/2,bearing_size,vertical_bearing_height], center = true);
 cylinder(h = vertical_bearing_height, r=bearing_size/2, $fn = 60);
}

module vertical_bearing_holes(){
  translate(v=[0,0,-1]) cylinder(h = vertical_bearing_height+10, r=bearing_diameter/2, $fn = 60);
  rotate(a=[0,0,-60]) translate(v=[10,0,vertical_bearing_height/2+1]) cube(size = [10,1,vertical_bearing_height+2], center = true);
}

difference(){
vertical_bearing_base();
vertical_bearing_holes();
}