block And 
  Modelica.Blocks.Interfaces.BooleanInPort inPort1(n=1)
    annotation (extent=[-110, 30; -90, 50]);
  Modelica.Blocks.Interfaces.BooleanInPort inPort2(n=1)
    annotation (extent=[-108, -50; -88, -30]);
  Modelica.Blocks.Interfaces.BooleanOutPort outPort(n=1)
    annotation (extent=[94, -10; 114, 10]);
equation 
  outPort.signal = inPort1.signal and inPort2.signal;
  annotation (Diagram);
end And;
