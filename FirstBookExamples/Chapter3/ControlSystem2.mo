within FirstBookExamples.Chapter3;
model ControlSystem2 "A PI Controller with Plant Model"
  extends FirstBookExamples.Icons.RunnableExample;
  SinusoidalSignal sinsig(
    A=0.2,
    F=0.3,
    offset=1.0) annotation (Placement(transformation(
        origin={-86,52},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Summation diff(scale2=-1.0) annotation (Placement(transformation(
          extent={{-60,40},{-40,60}})));
  Summation sum annotation (Placement(transformation(extent={{46,40},
            {66,60}})));
  Gain KP(K=0.4) annotation (Placement(transformation(extent={{-60,
            -20},{-40,0}})));
  Gain KI(K=1.0) annotation (Placement(transformation(extent={{20,-20},
            {40,0}})));
  Integrator integrator annotation (Placement(transformation(extent={
            {54,-20},{74,0}})));
  TransferFunction motor(c1=0.8, c2=0.1)
    annotation (Placement(transformation(
        origin={8,22},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(sinsig.out_sig, diff.in_sig1) annotation (Line(points={{-76,
          52},{-60,52}}));
  connect(diff.out_sig, KP.in_sig)
    annotation (Line(points={{-60,48},{-66,48},{-66,-10},{-60,-10}}));
  connect(KP.out_sig, KI.in_sig) annotation (Line(points={{-40,-10},{
          20,-10}}));
  connect(KP.out_sig, sum.in_sig1)
    annotation (Line(points={{-40,-10},{-16,-10},{-16,52},{46,52}}));
  connect(KI.out_sig, integrator.in_sig) annotation (Line(points={{40,
          -10},{54,-10}}));
  connect(integrator.out_sig, sum.in_sig2)
    annotation (Line(points={{74,-10},{80,-10},{80,52},{66,52}}));
  connect(sum.out_sig, motor.in_sig)
    annotation (Line(points={{46,48},{28,48},{28,22},{18,22}}));
  connect(motor.out_sig, diff.in_sig2)
    annotation (Line(points={{-2,22},{-10,22},{-10,52},{-40,52}}));
  annotation (experiment(StopTime=20),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter3/ControlSystem2.mos" "Simulate ControlSystem2"));
end ControlSystem2;
