use <abox.scad>

// A0 x dimensions in mm
paramsIsoBaseBoxX = 841;
// A0 y dimensions in mm
paramsIsoBaseBoxY = 1189;
// Base unit for box height
paramsBaseBoxZ = 26;
// Bottom stack unit z dimension
paramsStackShapeZ = 2.15;
// Bottom stack unit angle
paramsStackShapeAngle = 45;

module linearSimulation() {
  for (simBase = [4: 6]) {
    for (simZ = [2: 4]) {
      offsetX = (simZ - 2) * 600;
      offsetY = (simBase - 4) * 400;
      translate([offsetX, offsetY, 0]) aBox(simBase, simZ);
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
    aBox(simBase, simZ);
  }
}

// linearSimulation();
stackedSimulation();
// aBox(7, 2);