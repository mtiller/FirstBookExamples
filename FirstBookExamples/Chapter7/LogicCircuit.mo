within FirstBookExamples.Chapter7;
model LogicCircuit
  extends FirstBookExamples.Icons.RunnableExample;
  import BS = Modelica.Blocks.Sources;

  BS.BooleanPulse i1(width={50}, period={2})
    annotation (extent=[-84, 56; -64, 76]);
  BS.BooleanPulse i2(width={50}, period={4})
    annotation (extent=[-86, -4; -66, 16]);
  BS.BooleanPulse i3(width={50}, period={8})
    annotation (extent=[-86, -62; -66, -42]);
  And and1 annotation (extent=[-26, -4; -6, 16]);
  And and2 annotation (extent=[42, 52; 62, 72]);
  Or or1 annotation (extent=[50, -36; 70, -16]);
  Not not1 annotation (extent=[18, -4; 38, 16]);
  Not not2 annotation (extent=[-18, 56; 2, 76]);
  Boolean o1;
  Boolean o2;
equation
  // o1
  connect(i3.outPort, and1.inPort2)
    annotation (points=[-65, -52; -48, -52; -48, 2; -25.8, 2]);
  connect(not1.outPort, or1.inPort1)
    annotation (points=[38, 6; 44, 6; 44, -22; 50, -22]);
  connect(i2.outPort, or1.inPort2)
    annotation (points=[-65, 6; -55.5, 6; -55.5, -30; 50, -30]);
  o1 = or1.outPort.signal[1];
  // o2
  connect(i1.outPort, not2.inPort) annotation (points=[-63, 66; -18, 66]);
  connect(not2.outPort, and2.inPort1) annotation (points=[2, 66; 42, 66]);
  o2 = and2.outPort.signal[1];
  connect(and2.inPort2, i2.outPort)
    annotation (points=[42.2, 58; 20, 58; 20, 32; -56, 32; -56, 6; -65, 6]);
  connect(and1.outPort, not1.inPort) annotation (points=[-5.6, 6; 18, 6]);
  connect(i1.outPort, and1.inPort1)
    annotation (points=[-63, 66; -48, 66; -48, 10; -26, 10]);
  annotation (experiment(StopTime=16),
              Commands(file="LogicCircuit.mos" "Simulate LogicCircuit"),
              Diagram);
end LogicCircuit;
