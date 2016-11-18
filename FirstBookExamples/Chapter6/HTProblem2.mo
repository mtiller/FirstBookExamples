within FirstBookExamples.Chapter6;
model HTProblem2 "Variation on HTProblem1"
  extends FirstBookExamples.Icons.RunnableExample;
  Modelica.Blocks.Sources.Constant Tl(k={300.0})
    annotation (Placement(transformation(extent={{-88,40},{-68,60}},
          rotation=0)));
  Modelica.Blocks.Sources.Constant Tinf(k={600.0})
    annotation (Placement(transformation(extent={{20,40},{40,60}},
          rotation=0)));
  Modelica.Blocks.Sources.Step Tr(
    height={700.0},
    offset={300.0},
    startTime={10.0}) annotation (Placement(transformation(extent={{
            -24,40},{-4,60}}, rotation=0)));
  FixedTemperature left annotation (Placement(transformation(extent={
            {-60,-18},{-40,2}}, rotation=0)));
  FixedTemperature right annotation (Placement(transformation(extent=
            {{8,-18},{28,2}}, rotation=0)));
  FixedTemperature wall annotation (Placement(transformation(extent={
            {54,-20},{74,0}}, rotation=0)));
  ConductingRodWithConvection rod(
    n=10,
    L=10.0,
    k=1.0,
    cp=1.0,
    rho=1.0,
    h=0.3) annotation (Placement(transformation(extent={{-22,-44},{-2,
            -24}}, rotation=0)));
equation
  connect(Tl.y, left.T)
    annotation (Line(points={{-67,50},{-64,50},{-64,-8},{-60,-8}}));
  connect(Tr.y, right.T)
    annotation (Line(points={{-3,50},{-2,50},{-2,-8},{8,-8}}));
  connect(Tinf.y, wall.T)
    annotation (Line(points={{41,50},{44,50},{44,-10},{54,-10}}));
  connect(left.d, rod.a)
    annotation (Line(points={{-40,-8},{-36,-8},{-36,-34},{-22,-34}}));
  connect(rod.b, right.d)
    annotation (Line(points={{-2,-34},{32,-34},{32,-8},{28,-8}}));
  connect(wall.d, rod.ambient)
    annotation (Line(points={{74,-10},{80,-10},{80,-80},{-11.8,-80},{
          -11.8,-43.8}}));
  annotation (experiment(
      StopTime=50,
      Tolerance=1e-4,
      NumberOfIntervals=500),
      Commands(file="HTProblem2.mos" "Simulate HTProblem2"),
      Diagram(graphics));
end HTProblem2;
