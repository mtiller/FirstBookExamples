within FirstBookExamples.Chapter7;
model LogicCircuit
  extends FirstBookExamples.Icons.RunnableExample;
  import BS = Modelica.Blocks.Sources;

  BS.BooleanPulse i1(width=50, period=2)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  BS.BooleanPulse i2(width=50, period=4)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  BS.BooleanPulse i3(width=50, period=8)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  And and1 annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  And and2 annotation (Placement(transformation(extent={{60,46},{80,66}})));
  Or or1 annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Not not1 annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Not not2 annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Boolean o1;
  Boolean o2;
equation
  // o1
  o1 = or1.y;
  // o2
  o2 = and2.y;
  connect(and1.y, not1.u) annotation (Line(points={{1,0},{6,0},{18,0}}));
  connect(i1.y, and1.u1) annotation (Line(points={{-59,60},{-32,60},{-32,
          4},{-22,4}}, color={255,0,255}));
  connect(i1.y, not2.u) annotation (Line(points={{-59,60},{-40.5,60},{
          -22,60}}, color={255,0,255}));
  connect(not2.y, and2.u1) annotation (Line(points={{1,60},{30,60},{58,
          60}}, color={255,0,255}));
  connect(i2.y, and2.u2) annotation (Line(points={{-59,0},{-50,0},{-50,
          30},{30,30},{30,52},{38,52},{58,52}}, color={255,0,255}));
  connect(i3.y, and1.u2) annotation (Line(points={{-59,-60},{-40,-60},
          {-40,-4},{-22,-4}}, color={255,0,255}));
  connect(i2.y, or1.u2) annotation (Line(points={{-59,0},{-50,0},{-50,
          -34},{-50,-34},{-50,-34},{-50,-34},{58,-34}}, color={255,0,255}));
  connect(not1.y, or1.u1) annotation (Line(points={{41,0},{50,0},{50,-26},
          {58,-26}}, color={255,0,255}));
  annotation (experiment(StopTime=16),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter7/LogicCircuit.mos" "Simulate LogicCircuit"));
end LogicCircuit;
