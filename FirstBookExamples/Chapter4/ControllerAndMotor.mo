within FirstBookExamples.Chapter4;
model ControllerAndMotor
  import Modelica.Blocks;

  Blocks.Sources.Sine sinsig(
    amplitude={0.2},
    freqHz={0.3},
    offset={1.0}) annotation (Placement(transformation(extent={{-84,
            10},{-64,30}}, rotation=0)));
  replaceable PIController con(Kp=0.4) constrainedby Controller
    annotation (Placement(transformation(extent={{-8,8},{12,28}},
          rotation=0)));
  Blocks.Continuous.TransferFunction motor(a={0.8,0.1}, b={1})
    annotation (Placement(transformation(extent={{34,8},{54,28}},
          rotation=0)));
equation
  connect(sinsig.y, con.command) annotation (Line(points={{-63,20},{
          -8,20}}));
  connect(con.driver, motor.u) annotation (Line(points={{13,18},{32,
          18}}));
  connect(motor.y, con.sensor) annotation (Line(points={{55,18},{72,
          18},{72,-40},{-34,-40},{-34,11.8},{-7.2,11.8}}));
end ControllerAndMotor;
