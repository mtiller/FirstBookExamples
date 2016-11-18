within FirstBookExamples.Chapter10.FactoryModels;
model ElectricMotor
  extends Actuator;
  Modelica.Mechanics.Rotational.Inertia rotor(J=0.2)
    annotation (extent=[0, -10; 20, 10]);
  Modelica.Electrical.Analog.Basic.EMF EMF1
    annotation (extent=[-30, -10; -10, 10]);
  Modelica.Electrical.Analog.Basic.Resistor R1(R=250)
    annotation (extent=[-80, 30; -60, 50]);
  Modelica.Electrical.Analog.Basic.Inductor L1(L=2)
    annotation (extent=[-50, 30; -30, 50]);
equation
  connect(EMF1.flange_b, rotor.flange_a)
    annotation (points=[-10, 5.55112e-16; -5.55112e-16, 5.55112e-16]);
  connect(L1.n, EMF1.p) annotation (points=[-30, 40; -20, 40; -20, 10]);
  connect(R1.n, L1.p) annotation (points=[-60, 40; -50, 40]);
  connect(R1.p, p) annotation (points=[-80, 40; -100, 40]);
  connect(EMF1.n, n) annotation (points=[-20, -10; -20, -40; -100, -40]);
  connect(rotor.flange_b, driver) annotation (points=[20, 5.55112e-16; 100, 0]);
  annotation (
    Icon(
      Rectangle(extent=[-80, 60; 80, -60], style(
          color=0,
          gradient=2,
          fillColor=9)),
      Rectangle(extent=[90, 10; 80, -10], style(
          color=0,
          gradient=2,
          fillColor=8)),
      Line(points=[-90, 40; -80, 40]),
      Line(points=[-90, -40; -80, -40]),
      Polygon(points=[-40, -40; -60, -80; -80, -80; -80, -100; 80, -100; 80, -80;
             60, -80; 40, -40; -40, -40], style(color=0, fillColor=0))),
    Diagram(Text(
        extent=[-70, 10; -26, -8],
        string="Ideal Motor",
        style(color=0))));
end ElectricMotor;
