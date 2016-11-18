model PendulumSystem1 "Simple Pendulum"
  extends FirstBookExamples.Icons.RunnableExample;
  RotationalPendulum pend annotation (extent=[-70, -10; -50, 10], rotation=180);
  FrictionlessJoint joint annotation (extent=[-8, -10; 12, 10]);
  Modelica.Mechanics.Rotational.Fixed fixed
    annotation (extent=[48, -10; 68, 10], rotation=90);
  annotation (experiment(StopTime=20),
              Commands(file="PendulumSystem1.mos" "Simulate PendulumSystem1"));
equation
  connect(pend.p, joint.a) annotation (points=[-50, -1.22461e-015; -32, -1.22461e-015;
         -32, 0; -8, 0]);
  connect(joint.b, fixed.flange_b) annotation (points=[12, 0; 58, 0]);
end PendulumSystem1;
