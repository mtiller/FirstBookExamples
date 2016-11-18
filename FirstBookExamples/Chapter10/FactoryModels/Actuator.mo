within FirstBookExamples.Chapter10.FactoryModels;
partial model Actuator
  Modelica.Mechanics.Rotational.Interfaces.Flange_b driver
    annotation (Placement(transformation(extent={{90,-10},{110,10}},
          rotation=0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin p
    annotation (Placement(transformation(extent={{-110,30},{-90,50}},
          rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}},
          rotation=0)));
end Actuator;
