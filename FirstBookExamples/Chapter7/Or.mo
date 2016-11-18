within FirstBookExamples.Chapter7;
block Or
  Modelica.Blocks.Interfaces.BooleanInPort inPort1(n=1)
    annotation (extent=[-110, 30; -90, 50]);
  Modelica.Blocks.Interfaces.BooleanInPort inPort2(n=1)
    annotation (extent=[-110, -50; -90, -30]);
  Modelica.Blocks.Interfaces.BooleanOutPort outPort(n=1)
    annotation (extent=[92, -10; 112, 10]);
equation
  outPort.signal = inPort1.signal or inPort2.signal;
  annotation (Diagram);
end Or;
