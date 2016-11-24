within FirstBookExamples.Chapter10.FactoryModels;
model Factory
  extends FirstBookExamples.Icons.RunnableExample;
  BeltController controller(
    Kd=-20,
    Kp=-500,
    Td=0.01) annotation (Placement(transformation(extent={{-70,-20},{
            -30,20}})));
  replaceable ElectricMotor motor annotation (Placement(
        transformation(extent={{-8,-20},{32,20}})));
  ConveyorBelt conveyor annotation (Placement(transformation(extent={
            {50,-20},{90,20}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor position_sensor
    annotation (Placement(transformation(
        origin={40,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed_sensor
    annotation (Placement(transformation(
        origin={40,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(motor.driver, conveyor.axle)
    annotation (Line(points={{32,0},{40,0},{40,1.11022e-15},{50,
          1.11022e-15}},
        color={0,0,0}));
  connect(position_sensor.flange, motor.driver) annotation (Line(
        points={{40,30},{40,0},{32,0}},           color={0,0,0}));
  connect(speed_sensor.flange, motor.driver) annotation (Line(points={{40,-30},
          {40,0},{32,0}},                     color={0,0,0}));
  connect(controller.n, motor.n)
    annotation (Line(points={{-30,-8},{-8,-8}}, color={0,0,255}));
  connect(ground.p, controller.n) annotation (Line(points={{-20,-20},
          {-20,-20},{-20,-8},{-30,-8}}, color={0,0,255}));
  connect(controller.p, motor.p) annotation (Line(points={{-30,8},{
          -30,8},{-8,8}}, color={0,0,255}));
  connect(position_sensor.phi, controller.phi) annotation (Line(
        points={{40,51},{40,60},{-80,60},{-80,8},{-74,8}}, color={0,0,
          127}));
  connect(speed_sensor.w, controller.omega) annotation (Line(points={{40,-51},
          {40,-60},{-80,-60},{-80,-8},{-74,-8}},          color={0,0,
          127}));
  annotation (
    experiment(
      StopTime=100,
      Tolerance=1e-8),
    __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter10/Factory.mos" "Simulate Factory"),
    Diagram(graphics={
        Text(
          extent={{-66,30},{-34,18}},
          lineColor={0,0,0},
          textString=
               "Controller"),
        Text(
          extent={{-6,34},{26,24}},
          lineColor={0,0,0},
          textString=
               "Motor"),
        Text(
          extent={{56,24},{98,6}},
          lineColor={0,0,0},
          textString=
               "Conveyor Belt")}));
end Factory;
