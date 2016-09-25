model RLC4 "An RLC circuit using standard components" 
  extends BookExamples.Icons.RunnableExample;
  import Modelica.Electrical.Analog;
  
  Analog.Basic.Resistor R1(R=15) annotation (extent=[20, 40; 40, 60]);
  Analog.Basic.Resistor R2(R=5000)
    annotation (extent=[-24, 0; -4, 20], rotation=270);
  Analog.Basic.Capacitor C(C=100e-6)
    annotation (extent=[60, 0; 80, 20], rotation=270);
  Analog.Basic.Inductor L(L=100e-3)
    annotation (extent=[-60, 40; -40, 60], rotation=0);
  Analog.Sources.StepVoltage vs(startTime=1)
    annotation (extent=[-60, -44; -40, -24]);
  Analog.Basic.Ground g annotation (extent=[20, -64; 40, -44]);
  annotation (experiment(StopTime=2),
              Commands(file="RLC4.mos" "Simulate RLC4"));
equation 
  connect(vs.n, g.p) annotation (points=[-40, -34; 30, -34; 30, -44]);
  connect(vs.p, L.p)
    annotation (points=[-60, -34; -89.167, -34; -89.167, 50; -60, 50]);
  connect(L.n, R1.p) annotation (points=[-40, 50; 20, 50]);
  connect(L.n, R2.p) annotation (points=[-40, 50; -14, 50; -14, 20]);
  connect(R1.n, C.p) annotation (points=[40, 50; 70, 50; 70, 20]);
  connect(C.n, g.p) annotation (points=[70, 0; 70, -34; 30, -34; 30, -44]);
  connect(R2.n, g.p) annotation (points=[-14, 0; -14, -34; 30, -34; 30, -44]);
end RLC4;
