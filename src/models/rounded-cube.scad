
module roundedCube(x, y, z, r, scale=1, reversed=false, center=false, angle=0) {
  extrudeScale = scale != 1 ? scale : (x - (z * tan(angle) * 2))/x;
  echo(str("roundedCube scale=", extrudeScale));
  // Determine final tranformations
  translateX = center ? 0 : x/2;
  translateY = center ? 0 : y/2;
  translateZ = reversed ? -1*z : 0;
  mirrorZ = reversed ? 1 : 0;

  mirror([0,0,mirrorZ]) 
    translate([translateX, translateY, translateZ])
      // Draw
      linear_extrude(height=z,scale=extrudeScale) {
        translate([-x/2, -y/2, 0]) hull() {
          translate([r, r, 0]) circle(r);
          translate([x - r, r, 0]) circle(r);
          translate([r, y - r, 0]) circle(r);
          translate([x - r, y - r, 0]) circle(r);
        }
      }
}

%translate([0,0,4]) roundedCube(60, 40, 20, 5);
translate([5,5,0]) roundedCube(50, 30, 4, 5, reversed = true, angle = 30);