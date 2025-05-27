///////////////////////
// Private Parameters //
///////////////////////

/* [Hidden] */
hiddenResolution = 64;
$fn = hiddenResolution;

use <models/rounded-cube.scad>
use <tools/iso.scad>

// Bottom stack unit z dimension
paramsStackShapeZ = 2.15;
// Bottom stack unit angle
paramsStackShapeAngle = 45;
// Base unit for box height
paramsBaseBoxZ = 26;

///////////////////////
// Public Parameters //
///////////////////////

/* [Sizes] */

// ISO-216 base size
Box_Size = 4; // [1:A1, 2:A2, 3:A3, 4:A4, 5:A5, 6:A6, 7:A7, 8:A8]
// Box height
Box_Height = 2; // [1:10]

/* [Advanced] */

// Base wall length
Wall_Length = 3.5;
// Rounded value
Wall_Rounded = 7.5;

module aBox(base, z) {
  paramsWallLength = Wall_Length;
  paramsRoundedH = Wall_Rounded;
  // Calculate dimensions for A(n)
  paperSize = isoPaper(base);
  boxX = paperSize[0];
  boxY = paperSize[1];
  boxZ = paramsBaseBoxZ * z;

  echo("==== ABox - configuration ====");
  echo(str("boxX=", boxX));
  echo(str("boxY=", boxY));
  echo(str("boxZ=", boxZ));
  echo(str("paramsWallLength=", paramsWallLength));
  echo(str("paramsRoundedH=", paramsRoundedH));
  echo(str("paramsStackShapeZ=", paramsStackShapeZ));
  echo(str("paramsStackShapeAngle=", paramsStackShapeAngle));

  
  // Output the dimensions
  echo(str("A", base, " dimensions: ", boxX, "mm x ", boxY, "mm"));

  difference() {
    union() {
      translate([0, 0, paramsStackShapeZ]) {
        roundedCube(boxX, boxY, boxZ - paramsStackShapeZ, paramsRoundedH);
      }
      translate([0, 0, 0]) {
        roundedCube(
          boxX,
          boxY,
          paramsStackShapeZ,
          paramsRoundedH,
          angle=paramsStackShapeAngle,
          reversed = true
        );
      }
    }
    translate([paramsWallLength, paramsWallLength, paramsStackShapeZ + paramsWallLength]) {
      roundedCube(
        boxX - paramsWallLength * 2,
        boxY - paramsWallLength * 2,
        boxZ - paramsStackShapeZ,
        paramsRoundedH > paramsWallLength ? paramsRoundedH - paramsWallLength : 0.1
      );
    }
  }
}

aBox(Box_Size, Box_Height);