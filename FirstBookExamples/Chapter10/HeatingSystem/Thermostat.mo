within FirstBookExamples.Chapter10.HeatingSystem;
partial model Thermostat
  Thermal.Interfaces.Node_a thermal annotation (Placement(
        transformation(extent={{-110,70},{-90,90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
end Thermostat;
