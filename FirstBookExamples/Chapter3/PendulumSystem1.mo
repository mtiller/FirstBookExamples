within FirstBookExamples.Chapter3;
model PendulumSystem1 "Simple Pendulum"
  extends FirstBookExamples.Icons.RunnableExample;
  RotationalPendulum pend annotation (Placement(transformation(
        origin={-60,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  FrictionlessJoint joint annotation (Placement(transformation(extent=
           {{-8,-10},{12,10}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (
    Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90, origin={58,0})));
equation
  connect(joint.b, fixed.flange)
    annotation (Line(points={{12,0},{35,0},{58,0}}, color={0,0,0}));
  connect(pend.p, joint.a) annotation (Line(points={{-50,0},{-30,0},{-8,
          0}}, color={0,0,0}));
  annotation (experiment(StopTime=20),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter3/PendulumSystem1.mos" "Simulate PendulumSystem1"));
end PendulumSystem1;
