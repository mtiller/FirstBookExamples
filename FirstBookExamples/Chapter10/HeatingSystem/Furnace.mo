model Furnace
  parameter Modelica.SIunits.Power capacity(start=27e+3);
  annotation (
    Diagram(
      Rectangle(extent=[-60, 80; 60, 32], style(
          color=9,
          pattern=2,
          thickness=2)),
      Rectangle(extent=[-60, 26; 60, -50], style(
          color=9,
          pattern=2,
          thickness=2)),
      Text(
        extent=[-30, -52; 30, -66],
        string="Heating Circuit",
        style(color=0)),
      Text(
        extent=[-24, 92; 26, 82],
        string="Sensor Circuit",
        style(color=0))),
    Icon(
      Rectangle(extent=[-80, 80; 80, -80], style(
          color=0,
          thickness=2,
          fillColor=9)),
      Line(points=[-60, 0; -90, 0], style(color=41)),
      Line(points=[-40, 90; -40, 80]),
      Line(points=[40, 90; 40, 80]),
      Rectangle(extent=[-60, 60; 60, -60], style(color=0, fillColor=8)),
      Line(points=[-60, 40; -40, 40; -36, 44; -28, 36; -20, 44; -12, 36; -4, 44;
             4, 36; 12, 44; 20, 36; 28, 44; 36, 36; 40, 40; 60, 40], style(
            color=41)),
      Line(points=[-60, 20; -40, 20; -36, 24; -28, 16; -20, 24; -12, 16; -4, 24;
             4, 16; 12, 24; 20, 16; 28, 24; 36, 16; 40, 20; 60, 20], style(
            color=41)),
      Line(points=[-60, 0; -40, 0; -36, 4; -28, -4; -20, 4; -12, -4; -4, 4; 4,
            -4; 12, 4; 20, -4; 28, 4; 36, -4; 40, 0; 60, 0], style(color=41)),
      Line(points=[-60, -20; -40, -20; -36, -16; -28, -24; -20, -16; -12, -24;
            -4, -16; 4, -24; 12, -16; 20, -24; 28, -16; 36, -24; 40, -20; 60, -20],
           style(color=41)),
      Line(points=[-60, -40; -40, -40; -36, -36; -28, -44; -20, -36; -12, -44;
            -4, -36; 4, -44; 12, -36; 20, -44; 28, -36; 36, -44; 40, -40; 60, -40],
           style(color=41))));
  Thermal.Interfaces.Node_a thermal annotation (extent=[-110, -10; -90, 10]);
  Modelica.Electrical.Analog.Interfaces.PositivePin p
    annotation (extent=[-50, 90; -30, 110], rotation=180);
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    annotation (extent=[30, 90; 50, 110], rotation=180);
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (extent=[30, -50; 50, -30]);
  Modelica.Electrical.Analog.Sources.ConstantVoltage switch_voltage(V=5)
    annotation (extent=[10, 50; 30, 70]);
  Modelica.Electrical.Analog.Basic.Resistor R1(R=1e+6)
    annotation (extent=[-30, 50; -10, 70], rotation=180);
  Modelica.Electrical.Analog.Ideal.ControlledIdealSwitch relay(level=1e-3)
    annotation (extent=[-10, 10; 10, 30]);
  Thermal.MixedDomain.HeaterElement heating_element(R=120*120/capacity)
    annotation (extent=[-50, -10; -30, 10], rotation=270);
  Modelica.Electrical.Analog.Sources.ConstantVoltage heater_voltage(V=120)
    annotation (extent=[-10, -30; 10, -10]);
equation
  connect(ground.p, n) annotation (points=[40, -30; 40, 100]);
  connect(switch_voltage.n, ground.p)
    annotation (points=[30, 60; 40, 60; 40, 0; 40, -30]);
  connect(switch_voltage.p, R1.p) annotation (points=[10, 60; -10, 60]);
  connect(R1.n, p) annotation (points=[-30, 60; -40, 60; -40, 100]);
  connect(relay.control, p)
    annotation (points=[5.55112e-16, 30; 0, 40; -40, 40; -40, 100]);
  connect(relay.n, ground.p) annotation (points=[10, 20; 40, 20; 40, -30]);
  connect(heating_element.p, relay.p)
    annotation (points=[-40, 10; -40, 20; -10, 20]);
  connect(heating_element.thermal, thermal)
    annotation (points=[-35, 2.38698e-15; -100, 0], style(color=41));
  connect(heater_voltage.n, ground.p)
    annotation (points=[10, -20; 40, -20; 40, -30]);
  connect(heater_voltage.p, heating_element.n)
    annotation (points=[-10, -20; -40, -20; -40, -10]);
end Furnace;
