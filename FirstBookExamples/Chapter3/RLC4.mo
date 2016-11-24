within FirstBookExamples.Chapter3;
model RLC4 "An RLC circuit using standard components"
  extends FirstBookExamples.Icons.RunnableExample;
  import Modelica.Electrical.Analog;

  Analog.Basic.Resistor R1(R=15) annotation (Placement(transformation(
          extent={{20,40},{40,60}})));
  Analog.Basic.Resistor R2(R=5000)
    annotation (Placement(transformation(
        origin={-14,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Analog.Basic.Capacitor C(C=100e-6)
    annotation (Placement(transformation(
        origin={70,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Analog.Basic.Inductor L(L=100e-3)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Analog.Sources.StepVoltage vs(startTime=1, V=1)
    annotation (Placement(transformation(extent={{-60,-44},{-40,-24}})));
  Analog.Basic.Ground g annotation (Placement(transformation(extent={
            {20,-64},{40,-44}})));
equation
  connect(vs.n, g.p) annotation (Line(points={{-40,-34},{30,-34},{30,
          -44}}));
  connect(vs.p, L.p)
    annotation (Line(points={{-60,-34},{-89.167,-34},{-89.167,50},{
          -60,50}}));
  connect(L.n, R1.p) annotation (Line(points={{-40,50},{20,50}}));
  connect(L.n, R2.p) annotation (Line(points={{-40,50},{-14,50},{-14,
          20}}));
  connect(R1.n, C.p) annotation (Line(points={{40,50},{70,50},{70,20}}));
  connect(C.n, g.p) annotation (Line(points={{70,0},{70,-34},{30,-34},
          {30,-44}}));
  connect(R2.n, g.p) annotation (Line(points={{-14,0},{-14,-34},{30,
          -34},{30,-44}}));
  annotation (experiment(StopTime=2),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter3/RLC4.mos" "Simulate RLC4"));
end RLC4;
