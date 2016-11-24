within FirstBookExamples.Chapter6;
function CalcForce "Calculate Force on body1 due to body2"
  extends Modelica.Icons.Function;
  import Modelica.SIunits;

  input SIunits.Position body1[3];
  input SIunits.Mass M1;
  input SIunits.Position body2[3];
  input SIunits.Mass M2;
  output SIunits.Force on_body1[3];
protected
  SIunits.Distance r;
  SIunits.Force F;
algorithm
  r := sqrt((body1[1] - body2[1])^2 + (body1[2] - body2[2])^2 + (body1[3] -
    body2[3])^2);
  F := M1*M2*Modelica.Constants.G/r^2;
  on_body1 := F*(body2 - body1)/r;
end CalcForce;
