// A0 x dimensions in mm
paramsIsoBaseBoxX = 841;
// A0 y dimensions in mm
paramsIsoBaseBoxY = 1189;

function keepVectorXMax(a, b) = a > b ? [b, a] : [a, b];

function isoPaper(base) = keepVectorXMax(
  paramsIsoBaseBoxX / pow(2, base / 2),
  paramsIsoBaseBoxY / pow(2, base / 2)
);
