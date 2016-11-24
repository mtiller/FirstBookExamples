within FirstBookExamples.Chapter4;
model PIControllerAndMotor
  extends FirstBookExamples.Icons.RunnableExample;
  import Modelica.Blocks;

  Blocks.Sources.Sine sinsig(
    amplitude=0.2,
    freqHz=0.3,
    offset=1.0) annotation (Placement(transformation(extent={{-60,-10},
            {-40,10}})));
  PIController pic(Kp=0.4) annotation (Placement(transformation(
          extent={{-20,-10},{0,10}})));
  Blocks.Continuous.TransferFunction motor(a={0.8,0.1}, b={1})
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(sinsig.y, pic.command) annotation (Line(points={{-39,0},{-34,
          0},{-22,0}}));
  connect(pic.driver, motor.u) annotation (Line(points={{1,0},{16,0},{
          18,0}}));
  connect(motor.y, pic.sensor) annotation (Line(points={{41,0},{60,0},
          {60,-30},{-32,-30},{-32,-6},{-22,-6}}));
  annotation (experiment(StopTime=20),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter4/PIControllerAndMotor.mos" "Simulate Motor with PI controller"));
end PIControllerAndMotor;
