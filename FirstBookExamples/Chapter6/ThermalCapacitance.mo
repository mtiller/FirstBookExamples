within FirstBookExamples.Chapter6;
model ThermalCapacitance "Capacitance of a rod section"
  ThermalNode p "Midpoint connection" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  parameter Modelica.SIunits.SpecificHeatCapacity cp;
  parameter Modelica.SIunits.Density rho;
  parameter Modelica.SIunits.Length L;
  parameter Modelica.SIunits.Area A;
protected
  parameter Modelica.SIunits.Volume V=A*L;
equation
  // Conservation of energy
  V*cp*rho*der(p.T) = p.q;
end ThermalCapacitance;
