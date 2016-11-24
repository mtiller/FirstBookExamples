within FirstBookExamples.Chapter4;
model ControllerAndMotor
  import Modelica.Blocks;

  Blocks.Sources.Sine sinsig(
    amplitude=0.2,
    freqHz=0.3,
    offset=1.0)   annotation (Placement(transformation(extent={{-80,-10},
            {-60,10}})));
  replaceable PIController con(Kp=0.4) constrainedby Controller
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Blocks.Continuous.TransferFunction motor(a={0.8,0.1}, b={1})
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(sinsig.y, con.command) annotation (Line(points={{-59,0},{
          -10,0}}));
  connect(con.driver, motor.u) annotation (Line(points={{13,0},{22,0},
          {38,0}}));
  connect(motor.y, con.sensor) annotation (Line(points={{61,0},{70,0},
          {70,-40},{-30,-40},{-30,-6},{-10,-6}}));
end ControllerAndMotor;
