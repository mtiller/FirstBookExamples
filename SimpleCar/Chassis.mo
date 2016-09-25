package Chassis "A collection of chassis models and related components" 
  extends Modelica.Icons.Library2;
  model GenericCar "Generic car assembly" 
    extends Interfaces.Chassis;
    parameter Modelica.SIunits.Mass vehicle_mass=1200 "Vehicle curb weight";
    parameter Real final_drive_ratio=3.43 "Final drive ratio";
    Types.KilometersPerHour kmh "Vehicle speed";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Icon(
        Polygon(points=[-62, -40; 80, -40; 74, -22; 58, -16; 36, -12; 18, 6; -
              30, 6; -40, -12; -72, -20; -72, -36; -62, -40], style(color=0, 
              fillColor=9)), 
        Ellipse(extent=[-52, -28; -28, -52], style(pattern=0, fillColor=7)), 
        Ellipse(extent=[-50, -30; -30, -50], style(color=0, fillColor=10)), 
        Ellipse(extent=[48, -28; 72, -52], style(pattern=0, fillColor=7)), 
        Ellipse(extent=[50, -30; 70, -50], style(color=0, fillColor=10)), 
        Polygon(points=[16, 2; 30, -12; 10, -12; -4, -12; -4, 2; 16, 2], style
            (color=0, fillColor=8)), 
        Rectangle(extent=[-74, -30; -64, -36], style(color=0, fillColor=0)), 
        Ellipse(extent=[54, -34; 66, -46], style(color=0, fillColor=8)), 
        Ellipse(extent=[-46, -34; -34, -46], style(color=0, fillColor=8)), 
        Polygon(points=[-12, 2; -12, -12; -34, -12; -28, 0; -26, 2; -20, 2; -
              12, 2], style(color=0, fillColor=8)), 
        Polygon(points=[-6, 4; -6, -32; 24, -32; 32, -26; 32, -12; 16, 4; -6, 
              4], style(color=10)), 
        Line(points=[-40, -40; -40, -100], style(color=53)), 
        Text(extent=[-60, 40; 60, 20], string="%name")), 
      Window(
        x=0.41, 
        y=0.19, 
        width=0.31, 
        height=0.63), 
      Diagram, 
      Documentation(info="This model contains the primitives necessary to
model the chassis of a car.  This is a very simple model
with only a single inertia and not compliances in the
car frame.
"));
    Modelica.Mechanics.Rotational.IdealGear final_drive(final ratio=
          final_drive_ratio) annotation (extent=[30, -10; 50, 10], rotation=180
      );
    Chassis.Tire tire annotation (extent=[-60, -20; -20, 20]);
    Modelica.Mechanics.Translational.SlidingMass vehicle_inertia(final m=
          vehicle_mass) annotation (extent=[-20, 20; 20, 60]);
  equation 
    connect(tire.body_force, vehicle_inertia.flange_a) annotation (points=[-
          40, 20; -40, 40; -20, 40], style(color=57));
    connect(tire.road_force, road) annotation (points=[-40, -20; -40, -100], 
        style(color=57));
    connect(final_drive.flange_b, tire.axle) annotation (points=[30, 
          1.83187e-15; -20, 1.11022e-15]);
    connect(final_drive.flange_a, power) annotation (points=[50, -7.21645e-16
          ; 80, 0]);
    kmh = der(vehicle_inertia.flange_a.s)*3.6;
    speed.signal[1] = kmh;
  end GenericCar;
  annotation (
    Coordsys(
      extent=[0, 0; 434, 373], 
      grid=[1, 1], 
      component=[20, 20]), 
    Window(
      x=0.46, 
      y=0.03, 
      width=0.28, 
      height=0.42, 
      library=1, 
      autolayout=1), 
    Documentation(info="This package contains all the chassis models and chassis component models
for the 'SimpleCar' package.  Some of the physical characteristics in this
package were found in the Bosch Automotive Handbook, 3rd Edition.
"), 
    Icon(
      Ellipse(extent=[-55, -36; -35, -56], style(color=0, fillColor=10)), 
      Ellipse(extent=[-51, -40; -39, -52], style(color=0, fillColor=8)), 
      Ellipse(extent=[44, -35; 64, -55], style(color=0, fillColor=10)), 
      Ellipse(extent=[48, -39; 60, -51], style(color=0, fillColor=8)), 
      Line(points=[-68, -67; -45, -46], style(color=0)), 
      Line(points=[31, -66; 54, -45], style(color=0)), 
      Line(points=[-48, -50; 51, -50; 35, -63; -64, -63; -48, -50], style(
            color=0, thickness=2)), 
      Ellipse(extent=[-80, -57; -60, -77], style(color=0, fillColor=10)), 
      Ellipse(extent=[-75, -61; -63, -73], style(color=0, fillColor=8)), 
      Ellipse(extent=[21, -57; 41, -77], style(color=0, fillColor=10)), 
      Ellipse(extent=[25, -61; 37, -73], style(color=0, fillColor=8))));
  model Tire "Tire model" 
    parameter Modelica.SIunits.Radius tire_radius=.35 "Tire radius";
  protected 
    Modelica.SIunits.Position s_rel "Relative speed between chassis and road";
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[90, 10; 54, -10], style(gradient=2, fillColor=8)), 
        Ellipse(extent=[-60, 60; 60, -60], style(
            color=0, 
            thickness=2, 
            fillColor=9)), 
        Ellipse(extent=[-40, 40; 40, -40], style(color=0, fillColor=8))), 
      Window(
        x=0.51, 
        y=0.23, 
        width=0.37, 
        height=0.71), 
      Documentation(info="This tire model connects to a driven axle as well as the
vehicle chassis and the road.  The rotational velocity
of the axle is used to compute the relative translational
velocity between the road and the vehicle chassis based on
the tire radius.
"));
  public 
    Modelica.Mechanics.Translational.Interfaces.Flange_a road_force 
      annotation (extent=[-10, -110; 10, -90]);
    Modelica.Mechanics.Rotational.Interfaces.Flange_a axle annotation (extent=
          [90, -10; 110, 10]);
    Modelica.Mechanics.Translational.Interfaces.Flange_b body_force 
      annotation (extent=[-10, 90; 10, 110], layer="icon");
  equation 
    road_force.f = axle.tau/tire_radius;
    road_force.f + body_force.f = 0;
    //  road_force.s = body_force.s;
    s_rel = axle.phi*tire_radius;
    body_force.s = road_force.s + s_rel;
  end Tire;
  model Road 
    Modelica.Mechanics.Translational.Interfaces.Flange_a road_surface 
      annotation (extent=[-10, 90; 10, 110]);
    annotation (
      Icon(
        Rectangle(extent=[-100, 60; 100, -60], style(color=9, fillColor=9)), 
        Rectangle(extent=[-80, 4; -40, -6], style(
            color=49, 
            pattern=0, 
            fillColor=49)), 
        Rectangle(extent=[-20, 4; 20, -6], style(pattern=0, fillColor=49)), 
        Rectangle(extent=[40, 4; 80, -6], style(pattern=0, fillColor=49)), 
        Rectangle(extent=[-100, 54; 100, 46], style(pattern=0, fillColor=7)), 
        Rectangle(extent=[-100, -48; 100, -56], style(pattern=0, fillColor=7))
          , 
        Line(points=[0, 100; 0, 60], style(color=57)), 
        Text(extent=[-60, -60; 60, -100], string="%name")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.39, 
        y=0.24, 
        width=0.6, 
        height=0.6));
  equation 
    road_surface.s = 0;
  end Road;
  model SportsCarChassis "Sports Car Chassis" 
    extends Chassis.GenericCar(vehicle_mass=1250, final_drive_ratio=3.45);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.39, 
        y=0.34, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This model extends the generic car chassis with the physical
characteristics of the Ford Mustang.
"));
  equation 
    connect(final_drive.flange_b, wheel) annotation (points=[30, 1.83187e-15
          ; 30, -60; -20, -60]);
  end SportsCarChassis;
end Chassis;
