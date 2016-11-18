within FirstBookExamples.Chapter6;
model HTProblem1 "Conducting rod with boundary conditions"
  extends FirstBookExamples.Icons.RunnableExample;
  Modelica.Blocks.Sources.Constant Tl(k={300.0})
    annotation (Placement(transformation(extent={{-64,0},{-44,20}},
          rotation=0)));
  Modelica.Blocks.Sources.Step Tr(
    height={700.0},
    offset={300.0},
    startTime={10.0}) annotation (Placement(transformation(extent={{
            -62,-42},{-42,-22}}, rotation=0)));
  FixedTemperature left annotation (Placement(transformation(extent={
            {-24,0},{-4,20}}, rotation=0)));
  FixedTemperature right annotation (Placement(transformation(extent=
            {{-30,-42},{-10,-22}}, rotation=0)));
  ConductingRod rod(
    n=10,
    L=10.0,
    k=1.0,
    cp=1.0,
    rho=1.0) annotation (Placement(transformation(extent={{18,0},{38,
            20}}, rotation=0)));
equation
  connect(Tl.y, left.T) annotation (Line(points={{-43,10},{-24,10}}));
  connect(Tr.y, right.T) annotation (Line(points={{-41,-32},{-30,-32}}));
  connect(left.d, rod.a) annotation (Line(points={{-4,10},{18,10}}));
  connect(right.d, rod.b) annotation (Line(points={{-10,-32},{38,-32},
          {38,10}}));
  annotation (experiment(
      StopTime=50,
      Tolerance=1e-4,
      NumberOfIntervals=500),
      Commands(file="HTProblem1.mos" "Simulate HTProblem1"));
end HTProblem1;
