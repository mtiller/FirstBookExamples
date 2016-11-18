within FirstBookExamples.Chapter4;
model RLC5 "An RLC circuit using standard components"
  extends FirstBookExamples.Icons.RunnableExample;
  import Modelica.Electrical.Analog;

  replaceable model ResModel = Analog.Basic.Resistor;
  ResModel R1(R=15) annotation (extent=[36, 38; 56, 58]);
  ResModel R2(R=5000) annotation (extent=[-12, -6; 8, 14], rotation=270);
  Analog.Basic.Capacitor C(C=100e-6)
    annotation (extent=[72, -6; 92, 14], rotation=270);
  Analog.Basic.Inductor L(L=100e-3) annotation (extent=[-56, 38; -36, 58]);
  Analog.Sources.StepVoltage vs(startTime=1)
    annotation (extent=[-56, -56; -36, -36]);
  Analog.Basic.Ground g annotation (extent=[34, -66; 54, -46]);
equation
  connect(vs.n, g.p) annotation (points=[-36, -46; 44, -46]);
  connect(vs.p, L.p) annotation (points=[-56, -46; -78, -46; -78, 48; -56, 48]);
  connect(L.n, R1.p) annotation (points=[-36, 48; 36, 48]);
  connect(L.n, R2.p) annotation (points=[-36, 48; -2, 48; -2, 14]);
  connect(R1.n, C.p) annotation (points=[56, 48; 82, 48; 82, 14]);
  connect(C.n, g.p) annotation (points=[82, -6; 82, -46; 44, -46]);
  connect(R2.n, g.p) annotation (points=[-2, -6; -2, -46; 44, -46]);
  annotation (experiment(StopTime=2),
              Commands(file="RLC5.mos" "Simulate RLC5"),
              Diagram);
end RLC5;
