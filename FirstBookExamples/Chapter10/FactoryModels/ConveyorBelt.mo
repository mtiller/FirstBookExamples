within FirstBookExamples.Chapter10.FactoryModels;
class ConveyorBelt
  import Modelica.Mechanics.Rotational;
  Rotational.Interfaces.Flange_a axle annotation (extent=[-110, -10; -90, 10]);
  replaceable Rotational.IdealGear gears(ratio=5) constrainedby
    Rotational.Interfaces.TwoFlanges annotation (extent=[-80, -10; -60, 10]);
  Rotational.IdealGearR2T belt annotation (extent=[-10, -10; 10, 10]);
  Modelica.Mechanics.Translational.SlidingMass product(m=1)
    annotation (extent=[20, -10; 40, 10]);
  Rotational.Fixed ground annotation (extent=[-30, -60; -10, -40]);
  Rotational.Damper bearings(d=20)
    annotation (extent=[-30, -40; -10, -20], rotation=90);
  Rotational.Inertia shaft(J=0.3)
                                 annotation (extent=[-48, -10; -28, 10]);
equation
  connect(gears.flange_a, axle) annotation (points=[-80, 0; -100, 0]);
  connect(belt.flange_b, product.flange_a) annotation (points=[10, 0; 20, 0]);
  connect(bearings.flange_b, belt.flange_a)
    annotation (points=[-20, -20; -20, 0; -10, 0]);
  connect(bearings.flange_a, ground.flange_b)
    annotation (points=[-20, -40; -20, -50]);
  connect(shaft.flange_b, belt.flange_a) annotation (points=[-28, 0; -10, 0]);
  connect(gears.flange_b, shaft.flange_a) annotation (points=[-60, 0; -48, 0]);
  annotation (
    Icon(
      Ellipse(extent=[-70, 10; -50, -10], style(
          color=0,
          gradient=3,
          fillColor=9)),
      Line(points=[-90, 0; -70, 0], style(color=0)),
      Ellipse(extent=[50, 10; 70, -10], style(
          color=0,
          gradient=3,
          fillColor=9)),
      Line(points=[-60, 10; 60, 10], style(color=9, thickness=4)),
      Line(points=[-60, -10; 60, -10], style(color=9, thickness=4)),
      Ellipse(extent=[-30, 10; -10, -10], style(
          color=0,
          gradient=3,
          fillColor=9)),
      Ellipse(extent=[10, 10; 30, -10], style(
          color=0,
          gradient=3,
          fillColor=9)),
      Rectangle(extent=[-50, 30; -30, 10], style(
          color=0,
          thickness=2,
          fillColor=73)),
      Rectangle(extent=[30, 30; 50, 10], style(
          color=0,
          thickness=2,
          fillColor=46)),
      Rectangle(extent=[-50, 30; -30, 10], style(
          color=0,
          thickness=2,
          fillColor=46)),
      Rectangle(extent=[-10, 30; 10, 10], style(
          color=0,
          thickness=2,
          fillColor=46)),
      Line(points=[-80, 40; -60, 20], style(color=0, thickness=2)),
      Line(points=[-60, 20; -60, 26], style(color=0, thickness=2)),
      Line(points=[-60, 20; -66, 20], style(color=0, thickness=2)),
      Line(points=[60, 20; 80, 40], style(color=0, thickness=2)),
      Line(points=[74, 40; 80, 40], style(color=0, thickness=2)),
      Line(points=[80, 34; 80, 40], style(color=0, thickness=2)),
      Ellipse(extent=[-64, 4; -56, -4], style(color=0, fillColor=0)),
      Ellipse(extent=[56, 4; 64, -4], style(color=0, fillColor=0)),
      Line(points=[-60, -2; -60, -40], style(color=0, thickness=4)),
      Line(points=[-80, -40; 80, -40], style(color=0, thickness=4)),
      Line(points=[60, 0; 60, -40], style(color=0, thickness=4)),
      Rectangle(extent=[-80, -40; 80, -60], style(
          color=0,
          fillColor=7,
          fillPattern=7))));
end ConveyorBelt;
