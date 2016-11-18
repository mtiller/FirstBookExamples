within FirstBookExamples.Chapter10.FactoryModels;
model PlantModel
  ElectricMotor motor annotation (Placement(transformation(extent={{
            -10,-20},{30,20}}, rotation=0)));
  ConveyorBelt conveyor annotation (Placement(transformation(extent={
            {50,-20},{90,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}},
          rotation=0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage SignalVoltage1
    annotation (Placement(transformation(extent={{-44,-2},{-24,18}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput v annotation (Placement(
        transformation(extent={{-120,12},{-100,32}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor AngleSensor1
    annotation (Placement(transformation(extent={{42,24},{62,44}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput pos annotation (Placement(
        transformation(extent={{100,24},{120,44}}, rotation=0)));
equation
  connect(motor.driver, conveyor.axle)
    annotation (Line(points={{30,1.11022e-15},{50,1.11022e-15}},
        color={0,0,0}));
  connect(ground.p, motor.n) annotation (Line(points={{-20,-20},{-20,
          -8},{-10,-8}}));
  connect(SignalVoltage1.n, motor.p) annotation (Line(points={{-24,8},
          {-10,8}}));
  connect(SignalVoltage1.p, ground.p)
    annotation (Line(points={{-44,8},{-44,-8},{-20,-8},{-20,-20}}));
  connect(SignalVoltage1.u, v)
    annotation (Line(points={{-34,15},{-34,22},{-110,22}}));
  connect(AngleSensor1.flange, motor.driver) annotation (Line(points=
          {{42,34},{36,34},{36,0},{30,1.11022e-15}}));
  connect(AngleSensor1.y, pos) annotation (Line(points={{63,34},{110,
          34}}));
end PlantModel;
