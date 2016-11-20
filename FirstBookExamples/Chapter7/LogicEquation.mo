within FirstBookExamples.Chapter7;
block LogicEquation

  Modelica.Blocks.Interfaces.BooleanInput i1
    annotation (Placement(transformation(extent={{-140,40},{-100,80}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput i2
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput i3
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput o1
    annotation (Placement(transformation(extent={{100,40},{120,60}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput o2
    annotation (Placement(transformation(extent={{100,-60},{120,-40}},
          rotation=0)));
equation
  o1 = not (i1 and i3) or i2;
  o2 = not i1 and i2;
end LogicEquation;
