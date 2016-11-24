within FirstBookExamples.Chapter10.HeatingSystem;
model ThermostatSystem
  extends FirstBookExamples.Icons.RunnableExample;
  House house1(
    ground_temp=553.15,
    footprint=250,
    height=4,
    h_wall=4.33,
    k_ground=0.4)
               annotation (Placement(transformation(extent={{-60,60},
            {-20,100}})));
  Modelica.Blocks.Sources.Trapezoid amb_temp(
    amplitude=10,
    rising=4*60*60,
    width=4*60*60,
    falling=4*60*60,
    period=24*60*60,
    offset=273.15,
    startTime=9.5*60*60) annotation (Placement(transformation(
          extent={{-100,-10},{-80,10}})));
  House house2(
    ground_temp=553.15,
    footprint=250,
    height=4,
    h_wall=4.33,
    k_ground=0.4)
               annotation (Placement(transformation(extent={{-60,-60},
            {-20,-20}})));
  Furnace furnace1(capacity=15e+3) annotation (Placement(
        transformation(extent={{0,20},{40,60}})));
  Furnace furnace2(capacity=15e+3) annotation (Placement(
        transformation(extent={{0,-100},{40,-60}})));
  replaceable DigitalThermostat thermostat1(T_on=295, T_off=300)
    annotation (Placement(transformation(extent={{60,60},{100,100}})));
  replaceable MechanicalThermostat thermostat2(desired=295, switch(
      hysteresis=0.0030461741978671,
      Gon=100000.0,
      Roff=100000.0))
    annotation (Placement(transformation(extent={{60,-60},{100,-20}})));
equation
  connect(amb_temp.y, house1.Tamb)
    annotation (Line(points={{-79,5.55112e-16},{-70,0},{-70,80},{-60,
          80}}));
  connect(house2.Tamb, amb_temp.y)
    annotation (Line(points={{-60,-40},{-70,-40},{-70,0},{-79,
          5.55112e-16}}));
  connect(house1.n, furnace1.thermal)
    annotation (Line(points={{-20,80},{-20,40},{-1.11022e-15,40}},
        color={255,0,0}));
  connect(furnace2.thermal, house2.n) annotation (Line(points={{
          -1.11022e-15,-80},{-20,-80},{-20,-40}}, color={255,0,0}));
  connect(thermostat1.thermal, house1.n)
    annotation (Line(points={{60,96},{-20,96},{-20,80}}, color={255,0,
          0}));
  connect(thermostat1.p, furnace1.p)
    annotation (Line(points={{60,80},{12,80},{12,60}}));
  connect(furnace1.n, thermostat1.n)
    annotation (Line(points={{28,60},{28,64},{60,64}}));
  connect(thermostat2.p, furnace2.p)
    annotation (Line(points={{60,-40},{12,-40},{12,-60}}));
  connect(thermostat2.thermal, house2.n)
    annotation (Line(points={{60,-24},{-20,-24},{-20,-40}}, color={
          255,0,0}));
  connect(thermostat2.n, furnace2.n)
    annotation (Line(points={{60,-56},{28,-56},{28,-60}}));
  annotation (
    experiment(
      StopTime=100000,
      Tolerance=1e-8),
    __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter10/HeatingSystem.mos" "Simulate heating system"),
    Diagram(graphics={
        Text(
          extent={{48,58},{116,48}},
          lineColor={0,0,0},
          textString=
               "Digital Thermostat"),
        Text(
          extent={{50,-62},{118,-72}},
          lineColor={0,0,0},
          textString=
               "Mechanical Thermostat"),
        Text(
          extent={{-6,22},{46,10}},
          lineColor={0,0,0},
          textString=
               "Furnace"),
        Text(
          extent={{-6,-98},{46,-110}},
          lineColor={0,0,0},
          textString=
               "Furnace")}));
end ThermostatSystem;
