within FirstBookExamples.Chapter8;
model ThermalCapacitanceNL "Non-linear rod section"
  Thermal.Interfaces.Node n annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}})));
  parameter Modelica.SIunits.Density rho;
  parameter Modelica.SIunits.Volume V;
  replaceable ThermalPropertyModel props(T=n.T);
equation
  // Conservation of energy
  V*rho*der(props.u) = n.q;
end ThermalCapacitanceNL;
