within FirstBookExamples.Chapter7;
block Not

  Modelica.Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}},
          rotation=0)));
equation
  y = not u;
end Not;
