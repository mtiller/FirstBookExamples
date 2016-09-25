block Not 
  Modelica.Blocks.Interfaces.BooleanInPort inPort(n=1)
    annotation (extent=[-110, -10; -90, 10]);
  Modelica.Blocks.Interfaces.BooleanOutPort outPort(n=1)
    annotation (extent=[90, -10; 110, 10]);
equation 
  outPort.signal = not inPort.signal;
end Not;
