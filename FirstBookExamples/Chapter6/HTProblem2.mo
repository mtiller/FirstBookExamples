within FirstBookExamples.Chapter6;
model HTProblem2 "Variation on HTProblem1"
  extends FirstBookExamples.Icons.RunnableExample;
  Modelica.Blocks.Sources.Constant Tl(k=300.0)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Modelica.Blocks.Sources.Constant Tinf(k=600.0)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Sources.Step Tr(
    height=700.0,
    offset=300.0,
    startTime=10.0) annotation (Placement(transformation(extent={{-30,40},
            {-10,60}})));
  FixedTemperature left annotation (Placement(transformation(extent={{-50,-10},
            {-30,10}})));
  FixedTemperature right annotation (Placement(transformation(extent={{10,-10},
            {30,10}})));
  FixedTemperature wall annotation (Placement(transformation(extent={{60,-10},
            {80,10}})));
  ConductingRodWithConvection rod(
    n=10,
    L=10.0,
    k=1.0,
    cp=1.0,
    rho=1.0,
    h=0.3) annotation (Placement(transformation(extent={{-10,-40},{10,
            -20}})));
equation
  connect(Tl.y, left.T)
    annotation (Line(points={{-69,50},{-60,50},{-60,0},{-50,0}}));
  connect(Tr.y, right.T)
    annotation (Line(points={{-9,50},{0,50},{0,0},{10,0}}));
  connect(Tinf.y, wall.T)
    annotation (Line(points={{41,50},{50,50},{50,0},{60,0}}));
  connect(left.d, rod.a)
    annotation (Line(points={{-30,0},{-20,0},{-20,-30},{-10,-30}}));
  connect(rod.b, right.d)
    annotation (Line(points={{10,-30},{40,-30},{40,0},{30,0}}));
  connect(wall.d, rod.ambient)
    annotation (Line(points={{80,0},{92,0},{92,-60},{0.2,-60},{0.2,
          -39.8}}));
  annotation (experiment(
      StopTime=50),
      __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter6/HTProblem2.mos" "Simulate HTProblem2"));
end HTProblem2;
