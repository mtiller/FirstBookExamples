within FirstBookExamples.Chapter6;
model ThermalConduction "1-D Conduction Heat Transfer"
  import Modelica.SIunits;
  // Physical parameters
  parameter SIunits.ThermalConductivity k=1.0;
  parameter SIunits.Length L=1.0;
  parameter SIunits.Area A=1.0;

  // Connectors
  ThermalNode a annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
  ThermalNode b annotation (Placement(transformation(extent={{90,-10},
            {110,10}})));
equation
  a.q = A*k*(a.T - b.T)/L;
  b.q = -a.q;
end ThermalConduction;
