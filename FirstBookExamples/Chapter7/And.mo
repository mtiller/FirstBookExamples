within FirstBookExamples.Chapter7;
block And
  Modelica.Blocks.Interfaces.BooleanInPort inPort1(n=1)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInPort inPort2(n=1)
    annotation (Placement(transformation(extent={{-108,-50},{-88,-30}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutPort outPort(n=1)
    annotation (Placement(transformation(extent={{94,-10},{114,10}},
          rotation=0)));
equation
  outPort.signal = inPort1.signal and inPort2.signal;
  annotation (Diagram(graphics));
end And;
