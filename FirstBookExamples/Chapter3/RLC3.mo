within FirstBookExamples.Chapter3;
model RLC3 "Yet another RLC circuit"
  extends FirstBookExamples.Icons.RunnableExample;
  Resistor R1(R=15) annotation (extent=[20, 40; 40, 60]);
  Resistor R2(R=5000) annotation (extent=[-20, 0; 0, 20], rotation=270);
  Capacitor C(C=100e-6) annotation (extent=[50, 0; 70, 20], rotation=270);
  Inductor L(L=100e-3) annotation (extent=[-60, 40; -40, 60]);
  VoltageSource vs annotation (extent=[-60, -50; -40, -30]);
  Ground g annotation (extent=[30, -80; 50, -60], rotation=270);
equation
  connect(vs.n, g.ground) annotation (points=[-40, -40; 40, -40; 40, -60]);
  connect(vs.p, L.p) annotation (points=[-60, -40; -80, -40; -80, 50; -60, 50]);
  connect(L.n, R1.p) annotation (points=[-40, 50; 20, 50]);
  connect(L.n, R2.p) annotation (points=[-40, 50; -10, 50; -10, 20]);
  connect(R1.n, C.p) annotation (points=[40, 50; 60, 50; 60, 20]);
  connect(C.n, g.ground) annotation (points=[60, 0; 60, -40; 40, -40; 40, -60]);
  connect(R2.n, g.ground)
    annotation (points=[-10, 0; -10, -40; 40, -40; 40, -60]);
  annotation (experiment(StopTime=2),
              Commands(file="RLC3.mos" "Simulate RLC3"));
end RLC3;
