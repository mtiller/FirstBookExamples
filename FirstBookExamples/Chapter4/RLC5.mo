within FirstBookExamples.Chapter4;
model RLC5 "An RLC circuit using standard components"
  extends FirstBookExamples.Icons.RunnableExample;
  import Modelica.Electrical.Analog;

  replaceable model ResModel = Analog.Basic.Resistor;
  ResModel R1(R=15) annotation (Placement(transformation(extent={{40,50},
            {60,70}})));
  ResModel R2(R=5000) annotation (Placement(transformation(
        origin={0,-2},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Analog.Basic.Capacitor C(C=100e-6)
    annotation (Placement(transformation(
        origin={80,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Analog.Basic.Inductor L(L=100e-3) annotation (Placement(
        transformation(extent={{-60,50},{-40,70}})));
  Analog.Sources.StepVoltage vs(startTime=1, V=1)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Analog.Basic.Ground g annotation (Placement(transformation(extent={{40,-80},
            {60,-60}})));
equation
  connect(vs.n, g.p) annotation (Line(points={{-40,-60},{4,-60},{50,
          -60}}));
  connect(vs.p, L.p) annotation (Line(points={{-60,-60},{-80,-60},{
          -80,60},{-60,60}}));
  connect(L.n, R1.p) annotation (Line(points={{-40,60},{-2,60},{40,60}}));
  connect(L.n, R2.p) annotation (Line(points={{-40,60},{1.77636e-15,
          60},{1.77636e-15,8}}));
  connect(R1.n, C.p) annotation (Line(points={{60,60},{80,60},{80,10}}));
  connect(C.n, g.p) annotation (Line(points={{80,-10},{80,-60},{50,
          -60}}));
  connect(R2.n, g.p) annotation (Line(points={{-1.77636e-15,-12},{
          -1.77636e-15,-60},{50,-60}}));
  annotation (experiment(StopTime=2),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter4/RLC5.mos" "Simulate RLC5"));
end RLC5;
