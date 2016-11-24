within FirstBookExamples.Chapter10.HeatingSystem;
model MechanicalThermostat
  parameter Modelica.SIunits.Temperature desired;
protected
  constant Real factor=Modelica.Constants.pi/36;
  parameter Modelica.SIunits.Angle setting=-factor - 2*factor*(desired - 300)/5;

public
  extends Thermostat;
  Thermal.MixedDomain.RotationalSpring spring(
    c=1e+6,
    T_nom=300,
    dudT=Modelica.Constants.pi/90) annotation (Placement(
        transformation(extent={{-64,-26},{-44,-6}})));
  Modelica.Mechanics.Rotational.Components.Inertia mechanism_inertia(
      J=1e-5) annotation (Placement(transformation(extent={{-22,-26},
            {-2,-6}})));
  Modelica.Mechanics.Rotational.Components.Fixed rotation(phi0=
        setting) annotation (Placement(transformation(extent={{-90,
            -58},{-70,-38}})));
  MercurySwitch switch annotation (Placement(transformation(extent={{
            -20,0},{40,60}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=100)
    annotation (Placement(transformation(extent={{-66,-54},{-46,-34}})));
equation
  connect(spring.flange_b, mechanism_inertia.flange_a) annotation (Line(
        points={{-44,-16},{-40,-16},{-34,-16},{-22,-16}}, color={0,0,
          0}));
  connect(rotation.flange, spring.flange_a) annotation (Line(points={
          {-80,-48},{-80,-16},{-64,-16}}, color={0,0,0}));
  connect(mechanism_inertia.flange_b, switch.rot)
    annotation (Line(points={{-2,-16},{10,-16},{10,1.11022e-15}},
        color={0,0,0}));
  connect(p, switch.p) annotation (Line(points={{-100,0},{-40,0},{-40,
          30},{-20,30}}));
  connect(switch.n, n) annotation (Line(points={{40,30},{60,30},{60,
          -80},{-100,-80}}));
  connect(spring.node_a, thermal)
    annotation (Line(points={{-54,-10},{-54,80},{-100,80}}, color={
          255,0,0}));
  connect(damper.flange_a, rotation.flange) annotation (Line(points={
          {-66,-44},{-80,-44},{-80,-48}}, color={0,0,0}));
  connect(damper.flange_b, mechanism_inertia.flange_a) annotation (Line(
        points={{-46,-44},{-30,-44},{-30,-16},{-22,-16}}, color={0,0,
          0}));
  annotation (
    Diagram(graphics={
        Text(
          extent={{-18,68},{36,56}},
          lineColor={0,0,0},
          textString=
               "Mercury Switch"),
        Text(extent={{-78,-18},{-30,-30}}, textString=
                                               "Temperature Sensitive Spring"),
        Text(
          extent={{-118,70},{-82,58}},
          lineColor={255,0,0},
          textString=
               "thermal")}),
    Icon(graphics={
        Rectangle(
          extent={{100,100},{-100,-100}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-70,70},{70,-70}},
          lineColor={0,0,0},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-34,12},{0,0}}, color={0,0,0}),
        Line(points={{-24,26},{0,0}}, color={0,0,0}),
        Line(points={{-10,34},{0,0}}, color={0,0,0}),
        Line(points={{8,34},{0,0}}, color={0,0,0}),
        Line(points={{24,26},{0,0}}, color={0,0,0}),
        Line(points={{0,0},{34,10}}, color={0,0,0}),
        Ellipse(
          extent={{-28,28},{28,-28}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{2,0},{-12,22}},
          color={0,0,0},
          thickness=0.5)}));
end MechanicalThermostat;
