package Interfaces "Collection of interfaces for the 'SimpleCar' package" 
  extends Modelica.Icons.Library;
  connector EngineGeometryRequired 
    "Connector for components or subsystems that require geometry information" 
    input Modelica.SIunits.Length bore "Engine bore";
    input Modelica.SIunits.Length stroke "Engine stroke";
    input Modelica.SIunits.Length conrod "Connecting rod length";
    input Modelica.SIunits.Volume Vc "Clearance volume";
    input Modelica.SIunits.Area Ap "Piston area";
    input Modelica.SIunits.Volume Vd "Displaced volume";
    input Modelica.SIunits.Length crank "Crank length";
    annotation (
      Diagram, 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.39, 
        y=0.34, 
        width=0.6, 
        height=0.6), 
      Icon(
        Polygon(points=[-100, 100; 0, 0; -100, -100; -100, 98; -100, 100], 
            style(color=0, fillColor=7)), 
        Polygon(points=[-100, 100; 100, 100; 100, -100; -100, -100; 0, 0; -100
              , 100], style(color=0, fillColor=8)), 
        Text(extent=[-72, -72; 100, -100], string="%name")), 
      Documentation(info="This connector should be declared for each component that requires
information about engine geometry.
"));
  end EngineGeometryRequired;
  connector EngineGeometryProvided "Connector to provide geometry information"
     
    
    output Modelica.SIunits.Length bore "Engine bore";
    output Modelica.SIunits.Length stroke "Engine stroke";
    output Modelica.SIunits.Length conrod "Connecting rod length";
    output Modelica.SIunits.Volume Vc "Clearance volume";
    output Modelica.SIunits.Area Ap "Piston area";
    output Modelica.SIunits.Volume Vd "Displaced volume";
    output Modelica.SIunits.Length crank "Crank length";
    annotation (
      Icon(Polygon(points=[-100, 100; 0, 0; -100, -100; -100, 98; -100, 100], 
            style(color=0, fillColor=8)), Polygon(points=[-100, 100; 100, 100; 
              100, -100; -100, -100; 0, 0; -100, 100], style(color=0, fillColor
              =7))), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.3, 
        y=0.14, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This component is used with components that
provide geometry information.
"));
  end EngineGeometryProvided;
  connector Gas "Thermodynamic connector" 
    Modelica.SIunits.Pressure P "Gas pressure";
    Modelica.SIunits.Temperature T "Gas temperature";
    flow Modelica.SIunits.MassFlowRate mdot "Mass flow rate";
    flow Modelica.SIunits.HeatFlowRate q "Heat flow rate";
    annotation (
      Icon(Rectangle(extent=[-100, 100; 100, -100], style(color=41, fillColor=
                47)), Text(
          extent=[-100, -100; 100, -136], 
          string="%name", 
          style(color=45))), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.22, 
        y=0.1, 
        width=0.3, 
        height=0.75), 
      Diagram, 
      Documentation(info="This connector contains the potential and flow
variables associated with the gas moving
through the engine.  These potentials and flows
are from both the energy and mass domains.
"));
  end Gas;
  connector GearSelectorOutput "Controller indicated gear selection" 
    output Integer gear;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=77, fillColor=7)), Line(points=[60, 20; 60, -20], style(
              color=77))), 
      Window(
        x=0.27, 
        y=0.32, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This connector is an output from any transmission shifting
model.
"));
  end GearSelectorOutput;
  annotation (
    Coordsys(
      extent=[0, 0; 624, 353], 
      grid=[1, 1], 
      component=[20, 20]), 
    Window(
      x=0.01, 
      y=0.54, 
      width=0.4, 
      height=0.4, 
      library=1, 
      autolayout=1), 
    Documentation(info="This package contains numerous connector definitions and a few partial model 
definitions for the major vehicle subsystems.
"));
  connector GearSelectorInput "Gear selection input for transmissions" 
    input Integer gear;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=77, fillColor=79)), Polygon(points=[60, 20; 60, -20; 64, -
              18; 100, 0; 60, 20], style(color=77, fillColor=7))), 
      Window(
        x=0.39, 
        y=0.34, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This connectoris used as an input for transmissions.  The connector
contains information about what gear the transmission should be in.
"));
  end GearSelectorInput;
  partial model Transmission "Transmission Interface" 
    Interfaces.GearSelectorInput gear_selector annotation (extent=[-10, 100; 
          10, 120], rotation=270);
    Modelica.Mechanics.Rotational.Interfaces.Flange_a driveline annotation (
        extent=[-110, -10; -90, 10]);
    Modelica.Mechanics.Rotational.Interfaces.Flange_b engine annotation (
        extent=[90, -10; 110, 10]);
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
      Documentation(info="The transmission interface contains a connection to the engine, a connection to the
driveline and a gear selector input.  This interface is defined so that it can
be used in conjunction with replaceable declarations where the transmission interface
is the constraining type.
"));
  end Transmission;
  partial model ShiftStrategy "Shift strategy interface" 
    parameter Modelica.SIunits.Length tire_radius "Tire radius";
  protected 
    Types.KilometersPerHour kph "Vehicle speed";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Icon(
        Ellipse(extent=[-80, 80; 0, 0], style(color=0, fillColor=8)), 
        Line(points=[-74, 20; -40, 40], style(color=0)), 
        Line(points=[-80, 40; -40, 40], style(color=0)), 
        Line(points=[-74, 60; -40, 40], style(color=0)), 
        Line(points=[-60, 74; -40, 40], style(color=0)), 
        Line(points=[-40, 80; -40, 42], style(color=0)), 
        Line(points=[-20, 74; -40, 40], style(color=0)), 
        Line(points=[-6, 60; -40, 40], style(color=41)), 
        Line(points=[0, 40; -40, 40], style(color=41)), 
        Ellipse(extent=[-70, 70; -10, 10], style(pattern=0, fillColor=8)), 
        Line(points=[-40, 40; -60, 60], style(color=0, fillColor=0)), 
        Polygon(points=[-60, 60; -58, 52; -52, 58; -60, 60], style(color=0, 
              fillColor=0)), 
        Ellipse(extent=[-38, 42; -42, 38], style(color=0, fillColor=0)), 
        Line(points=[-90, 0; -40, 0], style(color=0, thickness=2)), 
        Line(points=[0, 40; 0, -100], style(color=77, thickness=2)), 
        Text(extent=[-80, -20; 80, -80], string="%name")), 
      Window(
        x=0.39, 
        y=0.34, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This is the basic interface for any shift strategy model.  It connects to the
axle of the car and, using the tire radius, computes the vehicles translational
speed. This speed is then used to determine the appropriate gear which is then
assigned to the output gear selector.
"));
  public 
    Interfaces.GearSelectorOutput gear_request annotation (extent=[-10, -120; 
          10, -100], rotation=270);
    Modelica.Mechanics.Rotational.Interfaces.Flange_a wheel annotation (extent
        =[-110, -10; -90, 10]);
  equation 
    kph = der(wheel.phi)*tire_radius*60*60/1000;
    wheel.tau = 0;
  end ShiftStrategy;
  partial model Chassis "Generic chassis interface" 
    Modelica.Mechanics.Translational.Interfaces.Flange_a road "Road contact" 
      annotation (extent=[-50, -110; -30, -90]);
    Modelica.Mechanics.Rotational.Interfaces.Flange_a power "Driveline" 
      annotation (extent=[70, -10; 90, 10]);
    Modelica.Blocks.Interfaces.OutPort speed(final n=1) annotation (extent=[50
          , -120; 70, -100], rotation=270);
    Modelica.Mechanics.Rotational.Interfaces.Flange_a wheel annotation (extent
        =[-30, -70; -10, -50]);
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
      Documentation(info="This chassis interface has connections for the driveline side of the transmission, the wheels, road and a vehicle speed output.
This interface can be used as the constraining type in a replaceable declaration to allow easy substitution of chassis models."
        ));
  end Chassis;
  partial model Cylinder 
    Modelica.Mechanics.Rotational.Interfaces.Flange_a crankshaft annotation (
        extent=[-10, -208; 10, -188]);
    Interfaces.Gas intake annotation (extent=[-110, 70; -90, 90]);
    Interfaces.Gas exhaust annotation (extent=[90, 70; 110, 90]);
    Interfaces.EngineGeometryRequired geom annotation (extent=[120, -60; 100, 
          -40]);
  end Cylinder;
  partial model Engine "Generic engine interface" 
    Modelica.Mechanics.Rotational.Interfaces.Flange_a crankshaft annotation (
        extent=[-110, -50; -90, -30]);
    Interfaces.Gas intake annotation (extent=[-110, 70; -90, 90]);
    Interfaces.Gas exhaust annotation (extent=[90, 70; 110, 90]);
    Interfaces.EngineGeometryRequired engine_geometry annotation (extent=[100
          , -10; 120, 10], rotation=180);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.21, 
        y=0.19, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This generic engine interface includes a connection for the crankshaft, the intake system, the exhause system and an input
for engine geometry information.  This interface can be used as the constraining type on replaceable declaration to allow
easy substitution of engine models.
"));
  end Engine;
end Interfaces;
