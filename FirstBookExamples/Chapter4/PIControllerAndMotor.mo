within FirstBookExamples.Chapter4;
model PIControllerAndMotor
  extends FirstBookExamples.Icons.RunnableExample;
  import Modelica.Blocks;

  Blocks.Sources.Sine sinsig(
    amplitude={0.2},
    freqHz={0.3},
    offset={1.0}) annotation (Placement(transformation(extent={{-70,
            20},{-50,40}}, rotation=0)));
  PIController pic(Kp=0.4) annotation (Placement(transformation(
          extent={{-22,18},{-2,38}}, rotation=0)));
  Blocks.Continuous.TransferFunction motor(a={0.8,0.1}, b={1})
    annotation (Placement(transformation(extent={{30,18},{50,38}},
          rotation=0)));
equation
  connect(sinsig.y, pic.command) annotation (Line(points={{-49,30},{
          -22,30}}));
  connect(pic.driver, motor.u) annotation (Line(points={{-1,28},{28,
          28}}));
  connect(motor.y, pic.sensor) annotation (Line(points={{51,28},{62,
          28},{62,-42},{-30,-42},{-30,22},{-21.8,22}}));
  annotation (experiment(StopTime=20),
              Commands(file="PIControllerAndMotor.mos" "Simulate Motor with PI controller"),
              Diagram(graphics));
end PIControllerAndMotor;
