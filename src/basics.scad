Resolution = 64;
$fn = Resolution;

// INPUT
inputIso = 4;
inputZLevel = 2;

// A0 dimensions in mm
paramsIsoBaseBoxX = 841;
paramsIsoBaseBoxY = 1189;
paramsBaseBoxZ = 26;
paramsWallLength = 3.5;
paramsRoundedH = 7.5;
paramsStackShapeZ = 2.15;
paramsStackShapeAngle = 45;


echo("==== ABox - configuration ====");
echo(str("paramsIsoBaseBoxX=", paramsIsoBaseBoxX));
echo(str("paramsIsoBaseBoxY=", paramsIsoBaseBoxY));
echo(str("paramsBaseBoxZ=", paramsBaseBoxZ));
echo(str("paramsWallLength=", paramsWallLength));
echo(str("paramsRoundedH=", paramsRoundedH));
echo(str("paramsStackShapeZ=", paramsStackShapeZ));
echo(str("paramsStackShapeAngle=", paramsStackShapeAngle));

use <tools/roundedCube.scad>

module isoCube(base, z) {
  // Calculate dimensions for A(n)
  boxX = paramsIsoBaseBoxX / pow(2, base / 2);
  boxY = paramsIsoBaseBoxY / pow(2, base / 2);
  boxZ = (paramsBaseBoxZ) * z;

  // Ensure boxX is the shorter side
  if (boxX > boxY) {
    temp = boxX;
    boxX = boxY;
    boxY = temp;
  }

  // Output the dimensions
  echo(str("A", base, " dimensions: ", boxX, "mm x ", boxY, "mm"));

  difference() {
    union() {
      translate([0, 0, paramsStackShapeZ]) {
        roundedCube(boxX, boxY, boxZ - paramsStackShapeZ, paramsRoundedH);
      }
      translate([paramsWallLength, paramsWallLength, 0]) {
        roundedCube(
          boxX - (2 * paramsWallLength),
          boxY - (2 * paramsWallLength),
          paramsStackShapeZ,
          paramsRoundedH > paramsWallLength ? paramsRoundedH - paramsWallLength : 0.1,
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

module linearSimulation() {
  for (simBase = [4: 6]) {
    for (simZ = [2: 4]) {
      offsetX = (simZ - 2) * 600;
      offsetY = (simBase - 4) * 400;
      translate([offsetX, offsetY, 0]) isoCube(simBase, simZ);
    }
  }
}

module stackedSimulation() {
  simZ = 1;
  for (simBase = [4: 10]) {
    offsetRotate = (simBase % 2) * 90;
    offsetX = (simBase % 2) * (paramsIsoBaseBoxY / pow(2, simBase / 2));
    offsetY = (simBase - 4) * 400;
    offsetZ = (paramsBaseBoxZ) * simZ * (simBase - 4) + (simBase * 2);
    translate([offsetX, 0, offsetZ])
    rotate(offsetRotate)
    isoCube(simBase, simZ);
  }
}

// linearSimulation();
// stackedSimulation();
isoCube(9, 1);