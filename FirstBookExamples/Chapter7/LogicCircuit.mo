within FirstBookExamples.Chapter7;
model LogicCircuit
  extends FirstBookExamples.Icons.RunnableExample;
  import BS = Modelica.Blocks.Sources;

  BS.BooleanPulse i1(width={50}, period={2})
    annotation (Placement(transformation(extent={{-84,56},{-64,76}},
          rotation=0)));
  BS.BooleanPulse i2(width={50}, period={4})
    annotation (Placement(transformation(extent={{-86,-4},{-66,16}},
          rotation=0)));
  BS.BooleanPulse i3(width={50}, period={8})
    annotation (Placement(transformation(extent={{-86,-62},{-66,-42}},
          rotation=0)));
  And and1 annotation (Placement(transformation(extent={{-26,-4},{-6,
            16}}, rotation=0)));
  And and2 annotation (Placement(transformation(extent={{42,52},{62,
            72}}, rotation=0)));
  Or or1 annotation (Placement(transformation(extent={{50,-36},{70,
            -16}}, rotation=0)));
  Not not1 annotation (Placement(transformation(extent={{18,-4},{38,
            16}}, rotation=0)));
  Not not2 annotation (Placement(transformation(extent={{-18,56},{2,
            76}}, rotation=0)));
  Boolean o1;
  Boolean o2;
equation
  // o1
  connect(i3.y, and1.u2)
    annotation (Line(points={{-65,-52},{-48,-52},{-48,2},{-25.8,2}}));
  connect(not1.y, or1.u1)
    annotation (Line(points={{38,6},{44,6},{44,-22},{50,-22}}));
  connect(i2.y, or1.u2)
    annotation (Line(points={{-65,6},{-55.5,6},{-55.5,-30},{50,-30}}));
  o1 = or1.y.signal[1];
  // o2
  connect(i1.y, not2.u) annotation (Line(points={{-63,66},{-18,66}}));
  connect(not2.y, and2.u1) annotation (Line(points={{2,66},{42,66}}));
  o2 = and2.y.signal[1];
  connect(and2.u2, i2.y)
    annotation (Line(points={{42.2,58},{20,58},{20,32},{-56,32},{-56,
          6},{-65,6}}));
  connect(and1.y, not1.u) annotation (Line(points={{-5.6,6},{18,6}}));
  connect(i1.y, and1.u1)
    annotation (Line(points={{-63,66},{-48,66},{-48,10},{-26,10}}));
  annotation (experiment(StopTime=16),
              __Dymola_Commands(file="LogicCircuit.mos" "Simulate LogicCircuit"),
              Diagram(graphics));
end LogicCircuit;
