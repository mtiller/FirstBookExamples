within FirstBookExamples.Chapter8;
model ACDC "AC to DC power supply"
  extends FirstBookExamples.Icons.RunnableExample;
  Modelica.Electrical.Analog.Basic.Resistor leak(R=10e+6)
    annotation (extent=[0, -10; 20, 10], rotation=270);
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (extent=[-180, -60; -160, -40]);
  Modelica.Electrical.Analog.Sources.SineVoltage voltage(V=120, freqHz=60)
    annotation (extent=[-180, -10; -160, 10], rotation=90);
  Modelica.Electrical.Analog.Ideal.IdealDiode diode
    annotation (extent=[-60, 10; -40, 30]);
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=1e-4)
    annotation (extent=[30, -10; 50, 10], rotation=270);
  Modelica.Electrical.Analog.Basic.Resistor short(R=1e-5)
    annotation (extent=[-30, 10; -10, 30]);
  Modelica.Electrical.Analog.Ideal.IdealTransformer transformer(n=22)
    annotation (extent=[-70, -40; -140, 40], rotation=180);
  Modelica.Electrical.Analog.Ideal.IdealSwitch switch(Gon=0)
    annotation (extent=[110, 30; 130, 10]);
  Modelica.Electrical.Analog.Basic.Resistor load(R=3000)
    annotation (extent=[130, -10; 150, 10], rotation=270);
  Modelica.Blocks.Sources.BooleanPulse load_switch(period={0.5})
    annotation (extent=[80, -10; 100, 10]);
equation
  connect(load.p, switch.n) annotation (points=[140, 10; 140, 20; 130, 20]);
  connect(ground.p, voltage.p) annotation (points=[-170, -40; -170, -10]);
  connect(capacitor.p, leak.p)
    annotation (points=[40, 10; 40, 20; 10, 20; 10, 10]);
  connect(short.n, leak.p) annotation (points=[-10, 20; 10, 20; 10, 10]);
  connect(switch.p, short.n) annotation (points=[110, 20; -10, 20]);
  connect(transformer.p1, ground.p)
    annotation (points=[-140, -20; -170, -20; -170, -40]);
  connect(voltage.n, transformer.n1)
    annotation (points=[-170, 10; -170, 20; -140, 20]);
  connect(leak.n, transformer.p2)
    annotation (points=[10, -10; 10, -20; -70, -20]);
  connect(capacitor.n, leak.n)
    annotation (points=[40, -10; 40, -20; 10, -20; 10, -10]);
  connect(load.n, capacitor.n)
    annotation (points=[140, -10; 140, -20; 40, -20; 40, -10]);
  connect(ground.p, transformer.p2)
    annotation (points=[-170, -40; -70, -40; -70, -20]);
  connect(load_switch.outPort, switch.control)
    annotation (points=[101, 5.55112e-016; 120, 0; 120, 14], style(color=81));
  connect(transformer.n2, diode.p) annotation (points=[-70, 20; -60, 20]);
  connect(diode.n, short.p) annotation (points=[-40, 20; -30, 20]);
  annotation (
    experiment(StopTime=1),
      Commands(file="ACDC.mos" "Simulate ACDC"),
    Diagram(
      Rectangle(extent=[-190, 52; 60, -60], style(
          color=8,
          pattern=2,
          thickness=2)),
      Text(
        extent=[-120, 72; -20, 52],
        string="Power Supply",
        style(color=0)),
      Rectangle(extent=[70, 52; 160, -60], style(
          color=8,
          pattern=2,
          thickness=2)),
      Text(
        extent=[72, 72; 160, 52],
        string="Load Device",
        style(color=0)),
      Text(
        extent=[8, 44; 42, 34],
        string="supply",
        style(color=0)),
      Text(
        extent=[4, 52; 18, 38],
        string="V",
        style(color=0)),
      Ellipse(extent=[8, 22; 12, 18], style(color=0, fillColor=0)),
      Text(
        extent=[132, 52; 146, 38],
        string="V",
        style(color=0)),
      Text(
        extent=[140, 44; 160, 34],
        string="load",
        style(color=0)),
      Ellipse(extent=[138, 22; 142, 18], style(color=0, fillColor=0)),
      Line(points=[10, 38; 10, 24], style(color=0)),
      Line(points=[140, 24; 140, 38], style(color=0))));
end ACDC;
