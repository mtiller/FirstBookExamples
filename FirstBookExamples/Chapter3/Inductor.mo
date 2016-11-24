within FirstBookExamples.Chapter3;
model Inductor "An electrical inductor"
  import Modelica.SIunits;

  parameter SIunits.Inductance L=1e-3 "Inductance";
  ElectricalPin p annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
  ElectricalPin n annotation (Placement(transformation(extent={{90,
            -10},{110,10}})));
equation
  L*der(p.i) = p.v - n.v;
  p.i + n.i = 0;
end Inductor;
