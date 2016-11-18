within FirstBookExamples.Chapter10.FactoryModels;
model Factory
  extends FirstBookExamples.Icons.RunnableExample;
  BeltController controller(
    Kd=-20,
    Kp=-500,
    Td=0.01) annotation (Placement(transformation(extent={{-70,-20},{
            -30,20}}, rotation=0)));
  replaceable ElectricMotor motor annotation (Placement(
        transformation(extent={{-10,-20},{30,20}}, rotation=0)));
  ConveyorBelt conveyor annotation (Placement(transformation(extent={
            {50,-20},{90,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor position_sensor
    annotation (Placement(transformation(
        origin={40,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed_sensor
    annotation (Placement(transformation(
        origin={40,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(controller.p, motor.p) annotation (Line(points={{-30,8},{
          -10,8}}));
  connect(controller.n, motor.n) annotation (Line(points={{-30,-8},{
          -10,-8}}));
  connect(motor.driver, conveyor.axle)
    annotation (Line(points={{30,1.11022e-15},{50,1.11022e-15}},
        color={0,0,0}));
  connect(ground.p, motor.n) annotation (Line(points={{-20,-20},{-20,
          -8},{-10,-8}}));
  connect(position_sensor.flange, motor.driver) annotation (Line(
        points={{40,20},{40,0},{30,1.11022e-15}}, color={0,0,0}));
  connect(position_sensor.y, controller.phi) annotation (Line(points=
          {{40,41},{40,50},{-80,50},{-80,8},{-72,8}}, color={0,0,0}));
  connect(speed_sensor.flange, motor.driver) annotation (Line(points=
          {{40,-20},{40,0},{30,1.11022e-15}}, color={0,0,0}));
  connect(speed_sensor.y, controller.omega) annotation (Line(points={
          {40,-41},{40,-50},{-80,-50},{-80,-8},{-72,-8}}, color={0,0,
          0}));
  annotation (
    experiment(
      StopTime=100,
      Tolerance=1e-8,
      NumberOfIntervals=500),
    Commands(file="Factory.mos" "Simulate Factory"),
    Diagram(graphics={
        Text(
          extent={{-66,30},{-34,18}},
          lineColor={0,0,0},
          textString=
               "Controller"),
        Text(
          extent={{-6,26},{26,16}},
          lineColor={0,0,0},
          textString=
               "Motor"),
        Text(
          extent={{56,24},{98,6}},
          lineColor={0,0,0},
          textString=
               "Conveyor Belt")}));
end Factory;
