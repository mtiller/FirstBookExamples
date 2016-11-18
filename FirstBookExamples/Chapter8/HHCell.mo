model HHCell "A Hodgkin-Huxley Nerve Cell"
  extends FirstBookExamples.Icons.RunnableExample;
  annotation (experiment(StopTime=0.8),
              Commands(file="HHCell.mos" "Simulate HHCell"));
protected
  parameter Modelica.SIunits.Diameter d=.5e-3;
  parameter Modelica.SIunits.Diameter L=5e-3;
  parameter Modelica.SIunits.Area area=(d/2)^2.0*Modelica.Constants.PI*L;
public
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude={-1e-8},
    width={10},
    period={20e-3},
    startTime={.5}) annotation (extent=[-100, -10; -80, 10]);
  Modelica.Electrical.Analog.Sources.SignalCurrent is
    annotation (extent=[-70, 20; -30, -20], rotation=90);
  HodgkinHuxley.MembraneCapacitance C(membrane_area=area)
    annotation (extent=[-20, -10; 0, 10], rotation=-90);
  HodgkinHuxley.SodiumChannel HH_Na(membrane_area=area)
    annotation (extent=[0, -20; 40, 20], rotation=-90);
  HodgkinHuxley.PotassiumChannel HH_K(membrane_area=area)
    annotation (extent=[30, -20; 70, 20], rotation=270);
  HodgkinHuxley.LeakageChannel HH_L(membrane_area=area)
    annotation (extent=[60, -20; 100, 20], rotation=-90);
  Modelica.Electrical.Analog.Basic.Ground g
    annotation (extent=[10, -78; 30, -58]);
equation
  connect(pulse.outPort, is.inPort) annotation (points=[-79, 0; -64.1, 0.1]);
  connect(HH_Na.p, is.p) annotation (points=[20, 20; 20, 40; -50, 40; -50, 20]);
  connect(HH_K.p, is.p) annotation (points=[50, 20; 50, 40; -50, 40; -50, 20]);
  connect(HH_L.p, is.p) annotation (points=[80, 20; 80, 40; -50, 40; -50, 20]);
  connect(C.p, is.p) annotation (points=[-10, 10; -10, 40; -50, 40; -50, 20]);
  annotation (
    Diagram(
      Line(points=[-100, 30; 100, 30], style(color=9, pattern=3)),
      Line(points=[-100, -30; 100, -30], style(color=9, pattern=3)),
      Line(points=[-100, 32; 100, 32], style(color=9, pattern=3)),
      Line(points=[-100, -32; 100, -32], style(color=9, pattern=3)),
      Text(
        extent=[-92, 60; -56, 52],
        string="Membrane Wall",
        style(color=9)),
      Line(points=[-70, 52; -70, 34], style(color=9, arrow=1))));
  connect(is.n, C.n)
    annotation (points=[-50, -20; -50, -40; -10, -40; -10, -10]);
  connect(HH_Na.n, C.n)
    annotation (points=[20, -20; 20, -40; -10, -40; -10, -10]);
  connect(HH_K.n, C.n)
    annotation (points=[50, -20; 50, -40; -10, -40; -10, -10]);
  connect(HH_L.n, C.n)
    annotation (points=[80, -20; 80, -40; -10, -40; -10, -10]);
  connect(HH_Na.n, g.p) annotation (points=[20, -20; 20, -58]);

end HHCell;
