model DigitalThermostat
  parameter Modelica.SIunits.Temperature T_on(start=300);
  parameter Modelica.SIunits.Temperature T_off(start=305);
protected
  parameter Real tc_C[:]={4.5e-8,3.4e-6,2.3e-3};
public
  extends Thermostat;
  annotation (
    Diagram(Text(extent=[-32, -36; 14, -46], string="controller")),
    Icon(
      Rectangle(extent=[100, 100; -100, -100], style(color=0, fillColor=9)),
      Rectangle(extent=[-80, 80; 80, 0], style(color=0, fillColor=8)),
      Rectangle(extent=[-48, -26; 48, -74], style(color=0, fillColor=8)),
      Rectangle(extent=[-4, -70; -44, -30], style(color=0, fillColor=7)),
      Rectangle(extent=[4, -30; 44, -70], style(color=0, fillColor=7)),
      Rectangle(extent=[-76, 76; 76, 4], style(color=0, fillColor=7)),
      Text(
        extent=[-76, 76; 34, 4],
        string="%T_on%",
        style(color=0, fillColor=7)),
      Text(
        extent=[26, 76; 68, 4],
        string="K",
        style(color=0)),
      Line(points=[0, -30; 0, -70], style(color=10)),
      Polygon(points=[24, -40; 14, -60; 34, -60; 24, -40], style(color=41,
            fillColor=42)),
      Polygon(points=[-34, -40; -24, -60; -14, -40; -34, -40], style(fillColor=
              70))));
  Thermal.MixedDomain.Thermocouple thermocouple(C=tc_C)
    annotation (extent=[-30, 40; 10, 80], rotation=180);
  DigitalCircuit controller(
    T_on=T_on,
    T_off=T_off,
    tc_C=tc_C) annotation (extent=[-40, -40; 20, 20]);
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (extent=[30, -60; 50, -40]);
equation
  connect(thermal, thermocouple.node_a)
    annotation (points=[-100, 80; -10, 80], style(color=41));
  connect(controller.ground, ground.p)
    annotation (points=[8, -28; 40, -28; 40, -40]);
  connect(controller.thermo_p, thermocouple.p)
    annotation (points=[8, 8; 20, 8; 20, 60; 10, 60]);
  connect(controller.thermo_n, thermocouple.n)
    annotation (points=[-28, 8; -40, 8; -40, 60; -30, 60]);
  connect(controller.furnace_p, p)
    annotation (points=[-28, -10; -60, -10; -60, 0; -100, 0]);
  connect(controller.furnace_n, n)
    annotation (points=[-28, -28; -60, -28; -60, -80; -100, -80]);
end DigitalThermostat;
