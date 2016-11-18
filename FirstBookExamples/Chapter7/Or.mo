within FirstBookExamples.Chapter7;
block Or
  Modelica.Blocks.Interfaces.BooleanInPort inPort1(n=1)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInPort inPort2(n=1)
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutPort outPort(n=1)
    annotation (Placement(transformation(extent={{92,-10},{112,10}},
          rotation=0)));
equation
  outPort.signal = inPort1.signal or inPort2.signal;
  annotation (Diagram(graphics));
end Or;
