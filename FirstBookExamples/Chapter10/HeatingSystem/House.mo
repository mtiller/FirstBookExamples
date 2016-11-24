within FirstBookExamples.Chapter10.HeatingSystem;
model House
  parameter Modelica.SIunits.Temperature ground_temp(start=280);
  parameter Modelica.SIunits.Area footprint(start=250);
  parameter Modelica.SIunits.Distance height(start=4);
  parameter Modelica.SIunits.CoefficientOfHeatTransfer h_wall(start=4.33);
  parameter Modelica.SIunits.ThermalConductivity k_ground(start=0.4);

  Thermal.Interfaces.Node_a n
    annotation ( Placement(
        transformation(extent={{90,-10},{110,10}})));

  Thermal.Basic1D.Capacitance indoors(
    cp=1000,
    rho=1.5,
    V=interior) annotation (Placement(transformation(extent={{-10,-10},
            {10,10}})));
  Thermal.Basic1D.BlackBodyRadiation roof(F=0.01,A=roof_area)
    annotation (Placement(transformation(
        origin={0,34},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Thermal.Basic1D.Convection wall(h=h_wall, A=wall_area)
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
  Thermal.Basic1D.Conduction floor(
    k=k_ground,
    L=4,
    A=footprint) annotation (Placement(transformation(
        origin={0,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Thermal.BoundaryConditions.FixedTemperature ground(T=ground_temp)
    annotation (Placement(transformation(
        origin={0,-82},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Thermal.BoundaryConditions.VariableTemperature ambient_temperature
    annotation (Placement(transformation(
        origin={-70,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Interfaces.RealInput Tamb
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Sources.Trapezoid sun_position(
    amplitude=140,
    rising=4*hour,
    width=4*hour,
    falling=4*hour,
    period=day,
    offset=240,
    startTime=8*hour) annotation (Placement(transformation(extent={
            {-80,66},{-60,86}})));
  Thermal.BoundaryConditions.VariableTemperature solar_temp
    annotation (Placement(transformation(
        origin={0,60},
        extent={{-10,-10},{10,10}},
        rotation=90)));

protected
  parameter Modelica.SIunits.Area roof_area=footprint;
  parameter Modelica.SIunits.Volume interior=footprint*height;
  parameter Modelica.SIunits.Area wall_area=height*footprint^0.5;
  constant Modelica.SIunits.Time hour=60*60;
  constant Modelica.SIunits.Time day=24*hour;
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Tc=n.T +
      Modelica.Constants.T_zero;
  Real Tf=Tc*9/5 + 32;

equation
  connect(wall.b, indoors.n) annotation (Line(points={{-32,
          5.55112e-16},{5.55112e-16,5.55112e-16}}, color={255,0,0}));
  connect(indoors.n, roof.a) annotation (Line(points={{5.55112e-16,
          5.55112e-16},{-5.55112e-17,24}}, color={255,0,0}));
  connect(indoors.n, floor.b) annotation (Line(points={{5.55112e-16,
          5.55112e-16},{1.16573e-15,-40}}, color={255,0,0}));
  connect(floor.a, ground.n)
    annotation (Line(points={{-5.55112e-17,-60},{2.38698e-15,-72}},
        color={255,0,0}));
  connect(indoors.n, n)
    annotation (Line(points={{5.55112e-16,5.55112e-16},{100,0}},
        color={255,0,0}));
  connect(ambient_temperature.n, wall.a)
    annotation (Line(points={{-60,-7.21645e-16},{-52,5.55112e-16}},
        color={255,0,0}));
  connect(Tamb, ambient_temperature.T)
    annotation (Line(points={{-100,0},{-82,1.88738e-15}}));
  connect(roof.b, solar_temp.n)
    annotation (Line(points={{1.16573e-15,44},{-5.55112e-17,50}},
        color={255,0,0}));
  connect(sun_position.y, solar_temp.T)
    annotation (Line(points={{-59,76},{1.22125e-15,76},{1.22125e-15,72}}));
  annotation (
    Diagram(graphics={
        Ellipse(
          extent={{-6,90},{4,80}},
          lineColor={255,127,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{16,96},{20,96},{20,20},{16,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{20,50},{22,50}},
          color={0,0,0},
          thickness=0.5),
        Text(extent={{24,54},{68,44}}, textString=
                                           "Solar Heating"),
        Line(
          points={{16,-32},{20,-32},{20,-94},{16,-94}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{20,-66},{24,-66}},
          color={0,0,0},
          thickness=0.5),
        Text(extent={{26,-60},{98,-72}}, textString=
                                             "Conduction to Ground"),
        Line(
          points={{-28,16},{-28,20},{-86,20},{-86,16}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-54,20},{-54,32},{-58,32}},
          color={0,0,0},
          thickness=0.5),
        Text(extent={{-60,40},{-106,32}}, textString=
                                              "Heat Loss"),
        Text(extent={{-60,32},{-106,24}}, textString=
                                              "Through Walls"),
        Line(
          points={{-86,16},{-86,-20},{-28,-20},{-28,16}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{14,20},{-20,20},{-20,96},{14,96}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{16,-32},{-20,-32},{-20,-94},{16,-94}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Text(extent={{6,-8},{66,-20}}, textString=
                                           "Thermal Inertia of the House")}),
    Icon(graphics={
        Rectangle(
          extent={{-60,20},{60,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,20},{0,80},{60,20},{-60,20}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-40},{10,-80}},
          lineColor={0,0,0},
          fillColor={191,95,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{4,-58},{8,-62}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-98,0},{-60,0}}),
        Line(points={{60,0},{90,0}}, color={255,0,0}),
        Rectangle(
          extent={{20,0},{40,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{30,0},{30,-20}}, color={0,0,0}),
        Line(points={{20,-10},{40,-10}}, color={0,0,0}),
        Rectangle(
          extent={{-40,0},{-20,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-30,0},{-30,-20}}, color={0,0,0}),
        Line(points={{-40,-10},{-20,-10}}, color={0,0,0})}));
end House;
