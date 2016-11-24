within FirstBookExamples.Chapter7;
block Lag
  parameter Real c=1 "lag time constant";
  parameter Real threshold=0.7 "logical threshold";
  Modelica.Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Real state "Continuous state of the wire";
equation
  c*der(state) = if u then 1 - state else -state;
  y = state >= threshold;
end Lag;
