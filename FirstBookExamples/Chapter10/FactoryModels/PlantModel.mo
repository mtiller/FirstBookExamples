within FirstBookExamples.Chapter10.FactoryModels;
model PlantModel
  ElectricMotor motor annotation (Placement(transformation(extent={{-20,-20},
            {20,20}})));
  ConveyorBelt conveyor annotation (Placement(transformation(extent={
            {50,-20},{90,20}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage SignalVoltage1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
        origin={-50,0})));
  Modelica.Blocks.Interfaces.RealInput v annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor AngleSensor1
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Modelica.Blocks.Interfaces.RealOutput pos annotation (Placement(
        transformation(extent={{100,30},{120,50}})));
equation
  connect(motor.driver, conveyor.axle)
    annotation (Line(points={{20,0},{36,0},{36,1.11022e-15},{50,
          1.11022e-15}},
        color={0,0,0}));
  connect(AngleSensor1.flange, motor.driver) annotation (Line(points={{40,40},
          {30,40},{30,0},{20,0}}));
  connect(v, SignalVoltage1.v) annotation (Line(points={{-120,0},{-57,
          0},{-57,4.44089e-16}}, color={0,0,127}));
  connect(SignalVoltage1.n, motor.p) annotation (Line(points={{-50,10},
          {-50,10},{-30,10},{-30,8},{-20,8}}, color={0,0,255}));
  connect(SignalVoltage1.p, motor.n) annotation (Line(points={{-50,
          -10},{-30,-10},{-30,-8},{-20,-8}}, color={0,0,255}));
  connect(ground.p, motor.n) annotation (Line(points={{-30,-20},{-30,
          -12},{-30,-8},{-20,-8}}, color={0,0,255}));
  connect(pos, pos) annotation (Line(points={{110,40},{106,40},{110,
          40}}, color={0,0,127}));
  connect(AngleSensor1.phi, pos) annotation (Line(points={{61,40},{
          110,40},{110,40}}, color={0,0,127}));
end PlantModel;
