within FirstBookExamples.Chapter6;
connector ThermalNode "Thermal Connector"
  Modelica.SIunits.Temp_K T(start=300);
  flow Modelica.SIunits.HeatFlowRate q;
end ThermalNode;
