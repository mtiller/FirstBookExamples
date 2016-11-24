within FirstBookExamples.Chapter10.HeatingSystem;
model Furnace
  parameter Modelica.SIunits.Power capacity(start=27e+3);
  Thermal.Interfaces.Node_a thermal annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p
    annotation (Placement(transformation(
        origin={-40,100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    annotation (Placement(transformation(
        origin={40,100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage switch_voltage(V=5)
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=1e+6)
    annotation (Placement(transformation(
        origin={-20,60},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Ideal.ControlledIdealClosingSwitch
                                                         relay(level=1e-3)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Thermal.MixedDomain.HeaterElement heating_element(R=120*120/capacity)
    annotation (Placement(transformation(
        origin={-40,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage heater_voltage(V=120)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
equation
  connect(ground.p, n) annotation (Line(points={{40,-30},{40,100}}));
  connect(switch_voltage.n, ground.p)
    annotation (Line(points={{30,60},{40,60},{40,0},{40,-30}}));
  connect(switch_voltage.p, R1.p) annotation (Line(points={{10,60},{
          -10,60}}));
  connect(R1.n, p) annotation (Line(points={{-30,60},{-40,60},{-40,
          100}}));
  connect(relay.control, p)
    annotation (Line(points={{5.55112e-16,30},{0,40},{-40,40},{-40,
          100}}));
  connect(relay.n, ground.p) annotation (Line(points={{10,20},{40,20},
          {40,-30}}));
  connect(heating_element.p, relay.p)
    annotation (Line(points={{-40,10},{-40,20},{-10,20}}));
  connect(heating_element.thermal, thermal)
    annotation (Line(points={{-35,2.38698e-15},{-100,0}}, color={255,
          0,0}));
  connect(heater_voltage.n, ground.p)
    annotation (Line(points={{10,-20},{40,-20},{40,-30}}));
  connect(heater_voltage.p, heating_element.n)
    annotation (Line(points={{-10,-20},{-40,-20},{-40,-10}}));
  annotation (
    Diagram(graphics={
        Rectangle(
          extent={{-60,80},{60,32}},
          lineColor={160,160,164},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Rectangle(
          extent={{-60,26},{60,-50}},
          lineColor={160,160,164},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{-30,-52},{30,-66}},
          lineColor={0,0,0},
          textString=
               "Heating Circuit"),
        Text(
          extent={{-24,92},{26,82}},
          lineColor={0,0,0},
          textString=
               "Sensor Circuit")}),
    Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,0},{-90,0}}, color={255,0,0}),
        Line(points={{-40,90},{-40,80}}),
        Line(points={{40,90},{40,80}}),
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,40},{-40,40},{-36,44},{-28,36},{-20,44},{
              -12,36},{-4,44},{4,36},{12,44},{20,36},{28,44},{36,36},
              {40,40},{60,40}}, color={255,0,0}),
        Line(points={{-60,20},{-40,20},{-36,24},{-28,16},{-20,24},{
              -12,16},{-4,24},{4,16},{12,24},{20,16},{28,24},{36,16},
              {40,20},{60,20}}, color={255,0,0}),
        Line(points={{-60,0},{-40,0},{-36,4},{-28,-4},{-20,4},{-12,-4},
              {-4,4},{4,-4},{12,4},{20,-4},{28,4},{36,-4},{40,0},{60,
              0}}, color={255,0,0}),
        Line(points={{-60,-20},{-40,-20},{-36,-16},{-28,-24},{-20,-16},
              {-12,-24},{-4,-16},{4,-24},{12,-16},{20,-24},{28,-16},{
              36,-24},{40,-20},{60,-20}}, color={255,0,0}),
        Line(points={{-60,-40},{-40,-40},{-36,-36},{-28,-44},{-20,-36},
              {-12,-44},{-4,-36},{4,-44},{12,-36},{20,-44},{28,-36},{
              36,-44},{40,-40},{60,-40}}, color={255,0,0})}));
end Furnace;
