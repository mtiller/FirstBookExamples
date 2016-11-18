within FirstBookExamples.Chapter7;
block Not
  Modelica.Blocks.Interfaces.BooleanInPort inPort(n=1)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutPort outPort(n=1)
    annotation (Placement(transformation(extent={{90,-10},{110,10}},
          rotation=0)));
equation
  outPort.signal = not inPort.signal;
end Not;
