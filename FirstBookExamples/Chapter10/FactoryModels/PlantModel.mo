within FirstBookExamples.Chapter10.FactoryModels;
model PlantModel
  ElectricMotor motor annotation (extent=[-10, -20; 30, 20]);
  ConveyorBelt conveyor annotation (extent=[50, -20; 90, 20]);
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (extent=[-30, -40; -10, -20]);
  Modelica.Electrical.Analog.Sources.SignalVoltage SignalVoltage1
    annotation (extent=[-44, -2; -24, 18]);
  Modelica.Blocks.Interfaces.InPort v annotation (extent=[-120, 12; -100, 32]);
  Modelica.Mechanics.Rotational.Sensors.AngleSensor AngleSensor1
    annotation (extent=[42, 24; 62, 44]);
  Modelica.Blocks.Interfaces.OutPort pos annotation (extent=[100, 24; 120, 44]);
equation
  connect(motor.driver, conveyor.axle)
    annotation (points=[30, 1.11022e-15; 50, 1.11022e-15], style(color=0));
  connect(ground.p, motor.n) annotation (points=[-20, -20; -20, -8; -10, -8]);
  connect(SignalVoltage1.n, motor.p) annotation (points=[-24, 8; -10, 8]);
  connect(SignalVoltage1.p, ground.p)
    annotation (points=[-44, 8; -44, -8; -20, -8; -20, -20]);
  connect(SignalVoltage1.inPort, v)
    annotation (points=[-34, 15; -34, 22; -110, 22]);
  connect(AngleSensor1.flange_a, motor.driver)
    annotation (points=[42, 34; 36, 34; 36, 0; 30, 1.11022e-15]);
  connect(AngleSensor1.outPort, pos) annotation (points=[63, 34; 110, 34]);
end PlantModel;
