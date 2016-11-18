within FirstBookExamples.Chapter7;
model LogicCircuitWithLag
  extends FirstBookExamples.Icons.RunnableExample;
  parameter Real c=1 "lag time constant";
  model Pulse
    extends Modelica.Blocks.Sources.BooleanPulse;
  end Pulse;
  Pulse i1(period={2}) annotation (Placement(transformation(extent={{
            -94,42},{-74,62}}, rotation=0)));
  Pulse i2(period={4}) annotation (Placement(transformation(extent={{
            -94,-4},{-74,16}}, rotation=0)));
  Pulse i3(period={8}) annotation (Placement(transformation(extent={{
            -94,-50},{-74,-30}}, rotation=0)));
  And and1 annotation (Placement(transformation(extent={{-42,-4},{-22,
            16}}, rotation=0)));
  And and2 annotation (Placement(transformation(extent={{32,38},{52,
            58}}, rotation=0)));
  Or or1 annotation (Placement(transformation(extent={{18,-36},{38,
            -16}}, rotation=0)));
  Not not1 annotation (Placement(transformation(extent={{32,-4},{52,
            16}}, rotation=0)));
  Not not2 annotation (Placement(transformation(extent={{-42,42},{-22,
            62}}, rotation=0)));
  Boolean o1;
  Boolean o2;
  Lag and1_lag(c=c) annotation (Placement(transformation(extent={{-4,
            -4},{16,16}}, rotation=0)));
  Lag and2_lag(c=c) annotation (Placement(transformation(extent={{68,
            38},{88,58}}, rotation=0)));
  Lag or1_lag(c=c) annotation (Placement(transformation(extent={{62,
            -36},{82,-16}}, rotation=0)));
  Lag not1_lag(c=c) annotation (Placement(transformation(extent={{66,
            -4},{86,16}}, rotation=0)));
  Lag not2_lag(c=c) annotation (Placement(transformation(extent={{-4,
            42},{16,62}}, rotation=0)));
equation
  connect(i1.y, and1.u1)
    annotation (Line(points={{-73,52},{-58,52},{-58,10},{-42,10}}));
  connect(i3.y, and1.u2)
    annotation (Line(points={{-73,-40},{-54,-40},{-54,2},{-41.8,2}}));
  connect(and1.y, and1_lag.u) annotation (Line(points={{-21.6,6},{-4,
          6}}));
  connect(and1_lag.y, not1.u) annotation (Line(points={{16,6},{32,6}}));
  connect(not1.y, not1_lag.u) annotation (Line(points={{52,6},{66,6}}));
  connect(i2.y, or1.u2)
    annotation (Line(points={{-73,6},{-66,6},{-66,-30},{18,-30}}));
  connect(or1.y, or1_lag.u) annotation (Line(points={{38.2,-26},{62,
          -26}}));
  o1 = or1_lag.y.signal[1];
  connect(i1.y, not2.u) annotation (Line(points={{-73,52},{-42,52}}));
  connect(not2.y, not2_lag.u) annotation (Line(points={{-22,52},{-4,
          52}}));
  connect(not2_lag.y, and2.u1) annotation (Line(points={{16,52},{32,
          52}}));
  connect(and2.y, and2_lag.u) annotation (Line(points={{52.4,48},{68,
          48}}));
  o2 = and2_lag.y.signal[1];
  connect(not1_lag.y, or1.u1)
    annotation (Line(points={{86,6},{98,6},{98,-10},{4,-10},{4,-22},{
          18,-22}}));
  connect(i2.y, and2.u2)
    annotation (Line(points={{-73,6},{-66,6},{-66,30},{26,30},{26,44},
          {32.2,44}}));
  annotation (experiment(StopTime=16),
              Commands(file="LogicCircuitWithLag.mos" "Simulate LogicCircuitWithLag"),
              Diagram(graphics));
end LogicCircuitWithLag;
