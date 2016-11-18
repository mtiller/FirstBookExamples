within FirstBookExamples.Chapter7;
model LogicCircuitWithLag
  extends FirstBookExamples.Icons.RunnableExample;
  parameter Real c=1 "lag time constant";
  model Pulse
    extends Modelica.Blocks.Sources.BooleanPulse;
  end Pulse;
  Pulse i1(period={2}) annotation (extent=[-94, 42; -74, 62]);
  Pulse i2(period={4}) annotation (extent=[-94, -4; -74, 16]);
  Pulse i3(period={8}) annotation (extent=[-94, -50; -74, -30]);
  And and1 annotation (extent=[-42, -4; -22, 16]);
  And and2 annotation (extent=[32, 38; 52, 58]);
  Or or1 annotation (extent=[18, -36; 38, -16]);
  Not not1 annotation (extent=[32, -4; 52, 16]);
  Not not2 annotation (extent=[-42, 42; -22, 62]);
  Boolean o1;
  Boolean o2;
  Lag and1_lag(c=c) annotation (extent=[-4, -4; 16, 16]);
  Lag and2_lag(c=c) annotation (extent=[68, 38; 88, 58]);
  Lag or1_lag(c=c) annotation (extent=[62, -36; 82, -16]);
  Lag not1_lag(c=c) annotation (extent=[66, -4; 86, 16]);
  Lag not2_lag(c=c) annotation (extent=[-4, 42; 16, 62]);
equation
  connect(i1.outPort, and1.inPort1)
    annotation (points=[-73, 52; -58, 52; -58, 10; -42, 10]);
  connect(i3.outPort, and1.inPort2)
    annotation (points=[-73, -40; -54, -40; -54, 2; -41.8, 2]);
  connect(and1.outPort, and1_lag.inPort) annotation (points=[-21.6, 6; -4, 6]);
  connect(and1_lag.outPort, not1.inPort) annotation (points=[16, 6; 32, 6]);
  connect(not1.outPort, not1_lag.inPort) annotation (points=[52, 6; 66, 6]);
  connect(i2.outPort, or1.inPort2)
    annotation (points=[-73, 6; -66, 6; -66, -30; 18, -30]);
  connect(or1.outPort, or1_lag.inPort) annotation (points=[38.2, -26; 62, -26]);
  o1 = or1_lag.outPort.signal[1];
  connect(i1.outPort, not2.inPort) annotation (points=[-73, 52; -42, 52]);
  connect(not2.outPort, not2_lag.inPort) annotation (points=[-22, 52; -4, 52]);
  connect(not2_lag.outPort, and2.inPort1) annotation (points=[16, 52; 32, 52]);
  connect(and2.outPort, and2_lag.inPort) annotation (points=[52.4, 48; 68, 48]);
  o2 = and2_lag.outPort.signal[1];
  connect(not1_lag.outPort, or1.inPort1)
    annotation (points=[86, 6; 98, 6; 98, -10; 4, -10; 4, -22; 18, -22]);
  connect(i2.outPort, and2.inPort2)
    annotation (points=[-73, 6; -66, 6; -66, 30; 26, 30; 26, 44; 32.2, 44]);
  annotation (experiment(StopTime=16),
              Commands(file="LogicCircuitWithLag.mos" "Simulate LogicCircuitWithLag"),
              Diagram);
end LogicCircuitWithLag;
