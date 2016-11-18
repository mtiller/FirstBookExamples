within FirstBookExamples.Chapter7;
block Lag
  parameter Real c=1 "lag time constant";
  parameter Real threshold=0.7
                              "logical threshold";
  Modelica.Blocks.Interfaces.BooleanInPort inPort(n=1)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutPort outPort(n=1)
    annotation (Placement(transformation(extent={{90,-10},{110,10}},
          rotation=0)));
protected
  Real state "Continuous state of the wire";
equation
  c*der(state) = if inPort.signal[1] then 1 - state else -state;
  outPort.signal[1] = state >= threshold;
end Lag;
