model House 
  parameter Modelica.SIunits.Temperature ground_temp(start=280);
  parameter Modelica.SIunits.Area footprint(start=250);
  parameter Modelica.SIunits.Distance height(start=4);
  parameter Modelica.SIunits.CoefficientOfHeatTransfer h_wall(start=4.33);
  parameter Modelica.SIunits.ThermalConductivity k_ground(start=0.4);
protected 
  parameter Modelica.SIunits.Area roof_area=footprint;
  parameter Modelica.SIunits.Volume interior=footprint*height;
  parameter Modelica.SIunits.Area wall_area=height*footprint^.5;
  constant Modelica.SIunits.Time hour=60*60;
  constant Modelica.SIunits.Time day=24*hour;
public 
  Thermal.Interfaces.Node_a n
    annotation (extent=[90, -10; 110, 10], layer="icon");
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100], 
      grid=[2, 2], 
      component=[20, 20]), 
    Window(
      x=0.11, 
      y=0.1, 
      width=0.53, 
      height=0.73), 
    Diagram(
      Ellipse(extent=[-6, 90; 4, 80], style(color=45, fillColor=49)), 
      Line(points=[16, 96; 20, 96; 20, 20; 16, 20], style(color=0, thickness=2)), 
         
      Line(points=[20, 50; 22, 50], style(color=0, thickness=2)), 
      Text(extent=[24, 54; 68, 44], string="Solar Heating"), 
      Line(points=[16, -32; 20, -32; 20, -94; 16, -94], style(color=0, 
            thickness=2)), 
      Line(points=[20, -66; 24, -66], style(color=0, thickness=2)), 
      Text(extent=[26, -60; 98, -72], string="Conduction to Ground"), 
      Line(points=[-28, 16; -28, 20; -86, 20; -86, 16], style(color=0, 
            thickness=2)), 
      Line(points=[-54, 20; -54, 32; -58, 32], style(color=0, thickness=2)), 
      Text(extent=[-60, 40; -106, 32], string="Heat Loss"), 
      Text(extent=[-60, 32; -106, 24], string="Through Walls"), 
      Line(points=[-86, 16; -86, -20; -28, -20; -28, 16], style(color=0, 
            pattern=3)), 
      Line(points=[14, 20; -20, 20; -20, 96; 14, 96], style(color=0, pattern=3)), 
         
      Line(points=[16, -32; -20, -32; -20, -94; 16, -94], style(color=0, 
            pattern=3)), 
      Text(extent=[6, -8; 66, -20], string="Thermal Inertia of the House")), 
    Icon(
      Rectangle(extent=[-60, 20; 60, -80], style(color=0, fillColor=8)), 
      Polygon(points=[-60, 20; 0, 80; 60, 20; -60, 20], style(color=0, 
            fillColor=10)), 
      Rectangle(extent=[-10, -40; 10, -80], style(color=0, fillColor=46)), 
      Ellipse(extent=[4, -58; 8, -62], style(color=0, fillColor=0)), 
      Line(points=[-98, 0; -60, 0]), 
      Line(points=[60, 0; 90, 0], style(color=41)), 
      Rectangle(extent=[20, 0; 40, -20], style(color=0, fillColor=7)), 
      Line(points=[30, 0; 30, -20], style(color=0)), 
      Line(points=[20, -10; 40, -10], style(color=0)), 
      Rectangle(extent=[-40, 0; -20, -20], style(color=0, fillColor=7)), 
      Line(points=[-30, 0; -30, -20], style(color=0)), 
      Line(points=[-40, -10; -20, -10], style(color=0))));
  
  Thermal.Basic1D.Capacitance indoors(
    cp=1000, 
    rho=1.5, 
    V=interior) annotation (extent=[-10, -10; 10, 10]);
  Thermal.Basic1D.BlackBodyRadiation roof(F=.01, A=roof_area)
    annotation (extent=[-10, 24; 10, 44], rotation=90);
  Thermal.Basic1D.Convection wall(h=h_wall, A=wall_area)
    annotation (extent=[-52, -10; -32, 10]);
  Thermal.Basic1D.Conduction floor(
    k=k_ground, 
    L=4, 
    A=footprint) annotation (extent=[-10, -60; 10, -40], rotation=90);
  Thermal.BoundaryConditions.FixedTemperature ground(T=ground_temp)
    annotation (extent=[-10, -92; 10, -72], rotation=270);
  Thermal.BoundaryConditions.VariableTemperature ambient_temperature
    annotation (extent=[-80, -10; -60, 10], rotation=180);
  Modelica.Blocks.Interfaces.InPort Tamb
    annotation (extent=[-110, -10; -90, 10]);
protected 
  Modelica.SIunits.CelsiusTemperature Tc=n.T + Modelica.Constants.T_zero;
  Real Tf=Tc*9/5 + 32;
public 
  Modelica.Blocks.Sources.Trapezoid sun_position(
    amplitude={140}, 
    rising={4*hour}, 
    width={4*hour}, 
    falling={4*hour}, 
    period={day}, 
    offset={240}, 
    startTime={8*hour}) annotation (extent=[-80, 66; -60, 86]);
  Thermal.BoundaryConditions.VariableTemperature solar_temp
    annotation (extent=[-10, 50; 10, 70], rotation=90);
equation 
  connect(wall.b, indoors.n) annotation (points=[-32, 5.55112e-16; 5.55112e-16, 
         5.55112e-16], style(color=41));
  connect(indoors.n, roof.a) annotation (points=[5.55112e-16, 5.55112e-16; -5.55112e-17, 
         24], style(color=41));
  connect(indoors.n, floor.b) annotation (points=[5.55112e-16, 5.55112e-16; 
        1.16573e-15, -40], style(color=41));
  connect(floor.a, ground.n)
    annotation (points=[-5.55112e-17, -60; 2.38698e-15, -72], style(color=41));
  connect(indoors.n, n)
    annotation (points=[5.55112e-16, 5.55112e-16; 100, 0], style(color=41));
  connect(ambient_temperature.n, wall.a)
    annotation (points=[-60, -7.21645e-16; -52, 5.55112e-16], style(color=41));
  connect(Tamb, ambient_temperature.T)
    annotation (points=[-100, 0; -81, 1.88738e-15]);
  connect(roof.b, solar_temp.n)
    annotation (points=[1.16573e-15, 44; -5.55112e-17, 50], style(color=41));
  connect(sun_position.outPort, solar_temp.T)
    annotation (points=[-59, 76; 0, 76; 1.22125e-15, 71]);
end House;
