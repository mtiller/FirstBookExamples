within FirstBookExamples.Chapter3;
model Resistor "An electrical resistor"
  import Modelica.SIunits;

  parameter SIunits.Resistance R=300 "Resistance";
  ElectricalPin p annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
  ElectricalPin n annotation (Placement(transformation(extent={{90,
            -10},{110,10}})));
equation
  // Naming the connection points
  R*p.i = p.v - n.v;
  p.i + n.i = 0;
end Resistor;
