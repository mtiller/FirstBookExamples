model BeltController 
  parameter Real Kd(start=1.0);
  parameter Real Kp(start=1.0);
  parameter Real Td(start=0.01);
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100], 
      grid=[2, 2], 
      component=[20, 20]), 
    Diagram(
      Rectangle(extent=[-48, 88; 48, 10], style(color=0, pattern=2)), 
      Text(
        extent=[-40, 100; 40, 88], 
        string="PID Controller", 
        style(color=0)), 
      Rectangle(extent=[-88, -46; -14, -90], style(color=0, pattern=2)), 
      Text(
        extent=[-88, -90; -14, -100], 
        string="Desired Response", 
        style(color=0))), 
    Icon(
      Rectangle(extent=[-80, 80; 80, -80], style(color=0, fillColor=8)), 
      Rectangle(extent=[-40, 60; 40, 10], style(fillColor=72)), 
      Rectangle(extent=[-40, -10; 40, -60], style(fillColor=72)), 
      Line(points=[-40, -40; -60, -40; -60, 40; -40, 40]), 
      Line(points=[-40, 40; -46, 46]), 
      Line(points=[-40, 40; -46, 34]), 
      Line(points=[40, 40; 60, 40; 60, -40; 40, -40]), 
      Line(points=[40, -40; 46, -34]), 
      Line(points=[40, -40; 46, -46]), 
      Line(points=[90, 40; 80, 40]), 
      Line(points=[90, -40; 80, -40]), 
      Line(points=[-100, 40; -80, 40]), 
      Line(points=[-100, -40; -80, -40])), 
    Window(
      x=0.29, 
      y=0.17, 
      width=0.6, 
      height=0.6));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    annotation (extent=[90, -50; 110, -30]);
  Modelica.Electrical.Analog.Interfaces.PositivePin p
    annotation (extent=[90, 30; 110, 50]);
  Modelica.Blocks.Interfaces.InPort phi
    annotation (extent=[-120, 30; -100, 50], layer="icon");
  Modelica.Blocks.Interfaces.InPort omega
    annotation (extent=[-120, -50; -100, -30], layer="icon");
  Modelica.Blocks.Sources.Trapezoid speed_profile(
    amplitude={0.5}, 
    rising={2.0}, 
    falling={2.0}, 
    period={10.0}, 
    offset={0}, 
    startTime={.2}) annotation (extent=[-80, -80; -60, -60]);
  Modelica.Blocks.Continuous.Integrator position_profile
    annotation (extent=[-50, -80; -30, -60]);
  Modelica.Electrical.Analog.Sources.SignalVoltage motor_voltage
    annotation (extent=[40, 20; 80, -20], rotation=90);
  Modelica.Blocks.Math.Feedback pos_error annotation (extent=[-82, 30; -62, 50]);
  Modelica.Blocks.Math.Gain Pcontrol(k={Kp})
    annotation (extent=[-24, 58; -4, 78]);
  Modelica.Blocks.Continuous.TransferFunction Dcontrol(b={Kd,0}, a={Td,1})
    annotation (extent=[-26, 20; -6, 40]);
  Modelica.Blocks.Math.Add sum annotation (extent=[12, 36; 32, 56]);
equation 
  connect(speed_profile.outPort, position_profile.inPort)
    annotation (points=[-59, -70; -52, -70]);
  connect(motor_voltage.p, p) annotation (points=[60, 20; 60, 40; 100, 40]);
  connect(motor_voltage.n, n) annotation (points=[60, -20; 60, -40; 100, -40]);
  connect(phi, pos_error.inPort1) annotation (points=[-110, 40; -80, 40]);
  connect(pos_error.outPort, Pcontrol.inPort)
    annotation (points=[-63, 40; -32, 40; -32, 68; -26, 68]);
  connect(Dcontrol.inPort, pos_error.outPort)
    annotation (points=[-28, 30; -32, 30; -32, 40; -63, 40]);
  connect(sum.outPort, motor_voltage.inPort)
    annotation (points=[33, 46; 38, 46; 38, 0; 46, -1.9984e-15]);
  connect(Dcontrol.outPort, sum.inPort2)
    annotation (points=[-5, 30; 0, 30; 0, 40; 10, 40]);
  connect(Pcontrol.outPort, sum.inPort1)
    annotation (points=[-3, 68; 4, 68; 4, 52; 10, 52]);
  connect(position_profile.outPort, pos_error.inPort2)
    annotation (points=[-29, -70; -20, -70; -20, -18; -72, -18; -72, 32]);
end BeltController;
