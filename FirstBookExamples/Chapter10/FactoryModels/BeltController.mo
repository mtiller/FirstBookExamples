within FirstBookExamples.Chapter10.FactoryModels;
model BeltController
  parameter Real Kd(start=1.0);
  parameter Real Kp(start=1.0);
  parameter Real Td(start=0.01);
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealInput phi
    annotation (Placement(
        transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput omega
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}), iconTransformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Sources.Trapezoid speed_profile(
    amplitude=0.5,
    rising=2.0,
    falling=2.0,
    period=10.0,
    offset=0,
    startTime=0.2)  annotation (Placement(transformation(extent={{-80,-80},
            {-60,-60}})));
  Modelica.Blocks.Continuous.Integrator position_profile
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage motor_voltage
    annotation (Placement(transformation(
        origin={60,0},
        extent={{20,-20},{-20,20}},
        rotation=90)));
  Modelica.Blocks.Math.Feedback pos_error annotation (Placement(
        transformation(extent={{-82,30},{-62,50}})));
  Modelica.Blocks.Math.Gain Pcontrol(k=Kp)
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Modelica.Blocks.Continuous.TransferFunction Dcontrol(a={Td,1}, b={
        Kd,0}) annotation (Placement(transformation(extent={{-30,20},
            {-10,40}})));
  Modelica.Blocks.Math.Add sum annotation (Placement(transformation(
          extent={{10,36},{30,56}})));
equation
  connect(speed_profile.y, position_profile.u)
    annotation (Line(points={{-59,-70},{-56,-70},{-52,-70}}));
  connect(motor_voltage.p, p) annotation (Line(points={{60,20},{60,40},
          {100,40}}));
  connect(motor_voltage.n, n) annotation (Line(points={{60,-20},{60,
          -40},{100,-40}}));
  connect(phi, pos_error.u1) annotation (Line(points={{-120,40},{-120,
          40},{-80,40}}));
  connect(pos_error.y, Pcontrol.u)
    annotation (Line(points={{-63,40},{-40,40},{-40,60},{-32,60}}));
  connect(Dcontrol.u, pos_error.y)
    annotation (Line(points={{-32,30},{-40,30},{-40,40},{-63,40}}));
  connect(Dcontrol.y, sum.u2)
    annotation (Line(points={{-9,30},{0,30},{0,40},{8,40}}));
  connect(Pcontrol.y, sum.u1)
    annotation (Line(points={{-9,60},{0,60},{0,52},{8,52}}));
  connect(position_profile.y, pos_error.u2)
    annotation (Line(points={{-29,-70},{-20,-70},{-20,-20},{-72,-20},
          {-72,32}}));
  connect(sum.y, motor_voltage.v) annotation (Line(points={{31,46},{
          38,46},{38,8.88178e-16},{46,8.88178e-16}}, color={0,0,127}));
  annotation (
    Diagram(graphics={
        Rectangle(
          extent={{-50,88},{46,10}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash),
        Text(
          extent={{-40,100},{40,88}},
          lineColor={0,0,0},
          textString=
               "PID Controller"),
        Rectangle(
          extent={{-88,-46},{-14,-90}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash),
        Text(
          extent={{-88,-90},{-14,-100}},
          lineColor={0,0,0},
          textString=
               "Desired Response")}),
    Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,60},{40,10}},
          lineColor={28,108,200},
          fillColor={159,191,223},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,-10},{40,-60}},
          lineColor={28,108,200},
          fillColor={159,191,223},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,-40},{-60,-40},{-60,40},{-40,40}}),
        Line(points={{-40,40},{-46,46}}),
        Line(points={{-40,40},{-46,34}}),
        Line(points={{40,40},{60,40},{60,-40},{40,-40}}),
        Line(points={{40,-40},{46,-34}}),
        Line(points={{40,-40},{46,-46}}),
        Line(points={{90,40},{80,40}}),
        Line(points={{90,-40},{80,-40}}),
        Line(points={{-100,40},{-80,40}}),
        Line(points={{-100,-40},{-80,-40}})}));
end BeltController;
