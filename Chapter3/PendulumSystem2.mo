model PendulumSystem2 "Simple Pendulum" 
  extends BookExamples.Icons.RunnableExample;
  RotationalPendulum p1(m=1, p(phi(start=1, fixed=true)))
    annotation (extent=[-88, -38; -68, -18], rotation=270);
  Modelica.Mechanics.Rotational.Spring s1(c=10)
    annotation (extent=[-52, 12; -32, 32]);
  Modelica.Mechanics.Rotational.Damper d1(d=.1, phi_rel(start=-1))
    annotation (extent=[-52, -10; -32, 10], rotation=0);
  RotationalPendulum p2(L=7, m=.7)
    annotation (extent=[-12, -38; 8, -18], rotation=270);
  Modelica.Mechanics.Rotational.Spring s2(c=2)
    annotation (extent=[28, 12; 48, 32]);
  Modelica.Mechanics.Rotational.Damper d2(d=.2)
    annotation (extent=[30, -10; 50, 10], rotation=0);
  Modelica.Mechanics.Rotational.Fixed fixed annotation (extent=[76, 12; 96, 32]);
  annotation (experiment(StopTime=20),
              Commands(file="PendulumSystem2.mos" "Simulate PendulumSystem2"));
equation 
  connect(p1.p, s1.flange_a) annotation (points=[-78, -18; -78, 22; -52, 22]);
  connect(p1.p, d1.flange_a)
    annotation (points=[-78, -18; -78, 22; -66, 22; -66, 0; -52, 0]);
  connect(s1.flange_b, p2.p) annotation (points=[-32, 22; -2, 22; -2, -18]);
  connect(d1.flange_b, p2.p)
    annotation (points=[-32, 0; -22, 0; -22, 22; -2, 22; -2, -18]);
  connect(p2.p, s2.flange_a) annotation (points=[-2, -18; -2, 22; 28, 22]);
  connect(p2.p, d2.flange_a)
    annotation (points=[-2, -18; -2, 22; 18, 22; 18, 0; 30, 0]);
  connect(s2.flange_b, fixed.flange_b) annotation (points=[48, 22; 86, 22]);
  connect(d2.flange_b, fixed.flange_b)
    annotation (points=[50, 0; 58, 0; 58, 22; 86, 22]);
end PendulumSystem2;
