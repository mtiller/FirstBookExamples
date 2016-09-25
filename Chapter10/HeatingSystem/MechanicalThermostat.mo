model MechanicalThermostat 
  parameter Modelica.SIunits.Temperature desired;
protected 
  constant Real factor=Modelica.Constants.PI/36;
  parameter Modelica.SIunits.Angle setting=-factor - 2*factor*(desired - 300)/5;
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100], 
      grid=[2, 2], 
      component=[20, 20]), 
    Diagram(
      Text(
        extent=[-18, 68; 36, 56], 
        string="Mercury Switch", 
        style(color=0)), 
      Text(extent=[-78, -18; -30, -30], string="Temperature Sensitive Spring"), 
         
      Text(
        extent=[-118, 70; -82, 58], 
        string="thermal", 
        style(color=41))), 
    Window(
      x=0.19, 
      y=0.15, 
      width=0.75, 
      height=0.72), 
    Icon(
      Rectangle(extent=[100, 100; -100, -100], style(color=0, fillColor=8)), 
      Rectangle(extent=[-100, 100; 100, -100], style(color=0, fillColor=8)), 
      Ellipse(extent=[-80, 80; 80, -80], style(color=0, fillColor=10)), 
      Ellipse(extent=[-70, 70; 70, -70], style(color=0, fillColor=9)), 
      Ellipse(extent=[-40, 40; 40, -40], style(color=0, fillColor=8)), 
      Line(points=[-34, 12; 0, 0], style(color=0)), 
      Line(points=[-24, 26; 0, 0], style(color=0)), 
      Line(points=[-10, 34; 0, 0], style(color=0)), 
      Line(points=[8, 34; 0, 0], style(color=0)), 
      Line(points=[24, 26; 0, 0], style(color=0)), 
      Line(points=[0, 0; 34, 10], style(color=0)), 
      Ellipse(extent=[-28, 28; 28, -28], style(color=0, fillColor=8)), 
      Line(points=[2, 0; -12, 22], style(color=0, thickness=2))));
  
public 
  extends Thermostat;
  Thermal.MixedDomain.RotationalSpring spring(
    c=1e+6, 
    T_nom=300, 
    dudT=Modelica.Constants.PI/90) annotation (extent=[-64, -26; -44, -6]);
  Modelica.Mechanics.Rotational.Inertia mechanism_inertia(J=1e-5)
    annotation (extent=[-22, -26; -2, -6]);
  Modelica.Mechanics.Rotational.Fixed rotation(phi0=setting)
    annotation (extent=[-90, -58; -70, -38]);
  MercurySwitch switch annotation (extent=[-20, 0; 40, 60]);
  Modelica.Mechanics.Rotational.Damper damper(d=100)
    annotation (extent=[-66, -54; -46, -34]);
equation 
  connect(spring.flange_b, mechanism_inertia.flange_a) annotation (points=[-44, 
         -16; -40, -16; -34, -16; -22, -16], style(color=0));
  connect(rotation.flange_b, spring.flange_a)
    annotation (points=[-80, -48; -80, -16; -64, -16], style(color=0));
  connect(mechanism_inertia.flange_b, switch.rot)
    annotation (points=[-2, -16; 10, -16; 10, 1.11022e-15], style(color=0));
  connect(p, switch.p) annotation (points=[-100, 0; -40, 0; -40, 30; -20, 30]);
  connect(switch.n, n) annotation (points=[40, 30; 60, 30; 60, -80; -100, -80]);
  connect(spring.node_a, thermal)
    annotation (points=[-54, -10; -54, 80; -100, 80], style(color=41));
  connect(damper.flange_a, rotation.flange_b)
    annotation (points=[-66, -44; -80, -44; -80, -48], style(color=0));
  connect(damper.flange_b, mechanism_inertia.flange_a) annotation (points=[-46, 
         -44; -30, -44; -30, -16; -22, -16], style(color=0));
end MechanicalThermostat;
