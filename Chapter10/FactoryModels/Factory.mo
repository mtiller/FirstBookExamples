model Factory 
  extends BookExamples.Icons.RunnableExample;
  annotation (
    experiment(
      StopTime=100, 
      Tolerance=1e-8, 
      NumberOfIntervals=500), 
    Commands(file="Factory.mos" "Simulate Factory"),
    Coordsys(
      extent=[-100, -100; 100, 100], 
      grid=[2, 2], 
      component=[20, 20]), 
    Window(
      x=0.4, 
      y=0.4, 
      width=0.6, 
      height=0.6), 
    Diagram(
      Text(
        extent=[-66, 30; -34, 18], 
        string="Controller", 
        style(color=0)), 
      Text(
        extent=[-6, 26; 26, 16], 
        string="Motor", 
        style(color=0)), 
      Text(
        extent=[56, 24; 98, 6], 
        string="Conveyor Belt", 
        style(color=0))));
  BeltController controller(
    Kd=-20, 
    Kp=-500, 
    Td=0.01) annotation (extent=[-70, -20; -30, 20]);
  replaceable ElectricMotor motor annotation (extent=[-10, -20; 30, 20]);
  ConveyorBelt conveyor annotation (extent=[50, -20; 90, 20]);
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (extent=[-30, -40; -10, -20]);
  Modelica.Mechanics.Rotational.Sensors.AngleSensor position_sensor
    annotation (extent=[30, 20; 50, 40], rotation=90);
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed_sensor
    annotation (extent=[30, -40; 50, -20], rotation=270);
equation 
  connect(controller.p, motor.p) annotation (points=[-30, 8; -10, 8]);
  connect(controller.n, motor.n) annotation (points=[-30, -8; -10, -8]);
  connect(motor.driver, conveyor.axle)
    annotation (points=[30, 1.11022e-015; 50, 1.11022e-015], style(color=0));
  connect(ground.p, motor.n) annotation (points=[-20, -20; -20, -8; -10, -8]);
  connect(position_sensor.flange_a, motor.driver)
    annotation (points=[40, 20; 40, 0; 30, 1.11022e-015], style(color=0));
  connect(position_sensor.outPort, controller.phi) annotation (points=[40, 41; 
        40, 50; -80, 50; -80, 8; -72, 8], style(color=0));
  connect(speed_sensor.flange_a, motor.driver)
    annotation (points=[40, -20; 40, 0; 30, 1.11022e-015], style(color=0));
  connect(speed_sensor.outPort, controller.omega) annotation (points=[40, -41; 
        40, -50; -80, -50; -80, -8; -72, -8], style(color=0));
end Factory;
