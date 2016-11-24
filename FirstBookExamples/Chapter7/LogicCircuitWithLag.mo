within FirstBookExamples.Chapter7;
model LogicCircuitWithLag
  extends FirstBookExamples.Icons.RunnableExample;
  parameter Real c=1 "lag time constant";
  model Pulse
    extends Modelica.Blocks.Sources.BooleanPulse;
  end Pulse;
  Pulse i1(period=2)   annotation (Placement(transformation(extent={{-90,40},
            {-70,60}})));
  Pulse i2(period=4)   annotation (Placement(transformation(extent={{-90,-8},
            {-70,12}})));
  Pulse i3(period=8)   annotation (Placement(transformation(extent={{-90,-50},
            {-70,-30}})));
  And and1 annotation (Placement(transformation(extent={{-40,-10},{-20,
            10}})));
  And and2 annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Or or1 annotation (Placement(transformation(extent={{32,-50},{52,-30}})));
  Not not1 annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Not not2 annotation (Placement(transformation(extent={{-50,40},{-30,
            60}})));
  Boolean o1;
  Boolean o2;
  Lag and1_lag(c=c) annotation (Placement(transformation(extent={{0,-10},
            {20,10}})));
  Lag and2_lag(c=c) annotation (Placement(transformation(extent={{70,40},
            {90,60}})));
  Lag or1_lag(c=c) annotation (Placement(transformation(extent={{70,-50},
            {90,-30}})));
  Lag not1_lag(c=c) annotation (Placement(transformation(extent={{70,-10},
            {90,10}})));
  Lag not2_lag(c=c) annotation (Placement(transformation(extent={{-8,40},
            {12,60}})));
equation
  o1 = or1_lag.y;
  connect(and2.y, and2_lag.u) annotation (Line(points={{51,50},{51,50},
          {68,50}}));
  o2 = and2_lag.y;
  connect(not2_lag.y, and2.u1) annotation (Line(points={{13,50},{20,50},
          {20,54},{28,54}}, color={255,0,255}));
  connect(and2.u2, i2.y) annotation (Line(points={{28,46},{20,46},{20,
          28},{-64,28},{-64,2},{-69,2}}, color={255,0,255}));
  connect(i2.y, or1.u2) annotation (Line(points={{-69,2},{-64,2},{-64,
          -44},{30,-44}}, color={255,0,255}));
  connect(i1.y, and1.u1) annotation (Line(points={{-69,50},{-62,50},{-60,
          50},{-60,4},{-42,4}}, color={255,0,255}));
  connect(i1.y, not2.u) annotation (Line(points={{-69,50},{-60.5,50},{
          -52,50}}, color={255,0,255}));
  connect(i3.y, and1.u2) annotation (Line(points={{-69,-40},{-60,-40},
          {-60,-4},{-42,-4}}, color={255,0,255}));
  connect(and1.y, and1_lag.u) annotation (Line(points={{-19,0},{-10.5,
          0},{-2,0}}, color={255,0,255}));
  connect(not1_lag.y, or1.u1) annotation (Line(points={{91,0},{96,0},{
          96,-20},{20,-20},{20,-36},{30,-36}}, color={255,0,255}));
  connect(not1.y, not1_lag.u)
    annotation (Line(points={{51,0},{68,0}}, color={255,0,255}));
  connect(and1_lag.y, not1.u)
    annotation (Line(points={{21,0},{28,0}}, color={255,0,255}));
  connect(or1.y, or1_lag.u)
    annotation (Line(points={{53,-40},{68,-40}}, color={255,0,255}));
  connect(not2.y, not2_lag.u)
    annotation (Line(points={{-29,50},{-10,50}}, color={255,0,255}));
  annotation (experiment(StopTime=16),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter7/LogicCircuitWithLag.mos" "Simulate LogicCircuitWithLag"));
end LogicCircuitWithLag;
