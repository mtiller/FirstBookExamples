within FirstBookExamples.Chapter10.FactoryModels;
model BeltController
  parameter Real Kd(start=1.0);
  parameter Real Kp(start=1.0);
  parameter Real Td(start=0.01);
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    annotation (Placement(transformation(extent={{90,-50},{110,-30}},
          rotation=0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin p
    annotation (Placement(transformation(extent={{90,30},{110,50}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput phi
    annotation (                             layer="icon", Placement(
        transformation(extent={{-120,30},{-100,50}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput omega
    annotation (                               layer="icon",
      Placement(transformation(extent={{-120,-50},{-100,-30}},
          rotation=0)));
  Modelica.Blocks.Sources.Trapezoid speed_profile(
    amplitude={0.5},
    rising={2.0},
    falling={2.0},
    period={10.0},
    offset={0},
    startTime={0.2})
                    annotation (Placement(transformation(extent={{-80,
            -80},{-60,-60}}, rotation=0)));
  Modelica.Blocks.Continuous.Integrator position_profile
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}},
          rotation=0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage motor_voltage
    annotation (Placement(transformation(
        origin={60,0},
        extent={{20,-20},{-20,20}},
        rotation=90)));
  Modelica.Blocks.Math.Feedback pos_error annotation (Placement(
        transformation(extent={{-82,30},{-62,50}}, rotation=0)));
  Modelica.Blocks.Math.Gain Pcontrol(k={Kp})
    annotation (Placement(transformation(extent={{-24,58},{-4,78}},
          rotation=0)));
  Modelica.Blocks.Continuous.TransferFunction Dcontrol(a={Td,1}, b={
        Kd,0}) annotation (Placement(transformation(extent={{-26,20},
            {-6,40}}, rotation=0)));
  Modelica.Blocks.Math.Add sum annotation (Placement(transformation(
          extent={{12,36},{32,56}}, rotation=0)));
equation
  connect(speed_profile.y, position_profile.u)
    annotation (Line(points={{-59,-70},{-52,-70}}));
  connect(motor_voltage.p, p) annotation (Line(points={{60,20},{60,40},
          {100,40}}));
  connect(motor_voltage.n, n) annotation (Line(points={{60,-20},{60,
          -40},{100,-40}}));
  connect(phi, pos_error.u1) annotation (Line(points={{-110,40},{-80,
          40}}));
  connect(pos_error.y, Pcontrol.u)
    annotation (Line(points={{-63,40},{-32,40},{-32,68},{-26,68}}));
  connect(Dcontrol.u, pos_error.y)
    annotation (Line(points={{-28,30},{-32,30},{-32,40},{-63,40}}));
  connect(sum.y, motor_voltage.u)
    annotation (Line(points={{33,46},{38,46},{38,0},{46,-1.9984e-15}}));
  connect(Dcontrol.y, sum.u2)
    annotation (Line(points={{-5,30},{0,30},{0,40},{10,40}}));
  connect(Pcontrol.y, sum.u1)
    annotation (Line(points={{-3,68},{4,68},{4,52},{10,52}}));
  connect(position_profile.y, pos_error.u2)
    annotation (Line(points={{-29,-70},{-20,-70},{-20,-18},{-72,-18},
          {-72,32}}));
  annotation (
    Diagram(graphics={
        Rectangle(
          extent={{-48,88},{48,10}},
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
