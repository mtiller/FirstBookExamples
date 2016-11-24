within FirstBookExamples.Chapter9;
function TwoBodyField
  extends Modelica.Icons.Function;
  extends GravityField;
protected
  Modelica.SIunits.Position b1[3];
  Modelica.SIunits.Position b2[3];
  Real n1[3];
  Real n2[3];
  Real mue(unit="m3/s2") = 1;
algorithm
  b1 := {0,0,0};
  b2 := {0,1,0};
  n1 := -(x - b1)/sqrt((x - b1)*(x - b1));
  n2 := -(x - b2)/sqrt((x - b2)*(x - b2));
  g := mue*n1/((x - b1)*(x - b1)) + mue*n2/((x - b2)*(x - b2));
end TwoBodyField;
