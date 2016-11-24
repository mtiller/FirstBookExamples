within FirstBookExamples.Chapter3;
model VoltageSource "A voltage source"
  import Modelica.SIunits;

  parameter SIunits.Voltage v1=0;
  parameter SIunits.Voltage v2=1;
  parameter SIunits.Time jump_time=1.0;

  ElectricalPin p annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
  ElectricalPin n annotation (Placement(transformation(extent={{90,
            -10},{110,10}})));
equation
  p.v - n.v = if time >= jump_time then v2 else v1;
  p.i + n.i = 0;
end VoltageSource;
