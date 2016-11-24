within FirstBookExamples.Chapter3;
model RLC3 "Yet another RLC circuit"
  extends FirstBookExamples.Icons.RunnableExample;
  Resistor R1(R=15) annotation (Placement(transformation(extent={{20,
            40},{40,60}})));
  Resistor R2(R=5000) annotation (Placement(transformation(
        origin={-10,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Capacitor C(C=100e-6) annotation (Placement(transformation(
        origin={60,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Inductor L(L=100e-3) annotation (Placement(transformation(extent={{
            -60,40},{-40,60}})));
  VoltageSource vs annotation (Placement(transformation(extent={{-60,
            -50},{-40,-30}})));
  Ground g annotation (Placement(transformation(
        origin={40,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(vs.n, g.ground) annotation (Line(points={{-40,-40},{40,-40},
          {40,-60}}));
  connect(vs.p, L.p) annotation (Line(points={{-60,-40},{-80,-40},{
          -80,50},{-60,50}}));
  connect(L.n, R1.p) annotation (Line(points={{-40,50},{20,50}}));
  connect(L.n, R2.p) annotation (Line(points={{-40,50},{-10,50},{-10,
          20}}));
  connect(R1.n, C.p) annotation (Line(points={{40,50},{60,50},{60,20}}));
  connect(C.n, g.ground) annotation (Line(points={{60,0},{60,-40},{40,
          -40},{40,-60}}));
  connect(R2.n, g.ground)
    annotation (Line(points={{-10,0},{-10,-40},{40,-40},{40,-60}}));
  annotation (experiment(StopTime=2),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter3/RLC3.mos" "Simulate RLC3"));
end RLC3;
