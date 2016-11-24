within FirstBookExamples.SimpleCar;
package Interfaces "Collection of interfaces for the 'SimpleCar' package"
  extends Modelica.Icons.Package;
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
      Icon(graphics={
          Polygon(
            points={{-100,100},{0,0},{-100,-100},{-100,98},{-100,100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,100},{100,100},{100,-100},{-100,-100},{0,0},
                {-100,100}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(extent={{-72,-72},{100,-100}}, textString=
                                                  "%name")}),
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
      Icon(graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,0,0},
            fillColor={255,191,127},
            fillPattern=FillPattern.Solid), Text(
            extent={{-100,-100},{100,-136}},
            lineColor={255,127,0},
            textString=
                 "%name")}),
      Documentation(info="This connector contains the potential and flow
variables associated with the gas moving
through the engine.  These potentials and flows
are from both the energy and mass domains.
"));
  end Gas;

  connector GearSelectorOutput "Controller indicated gear selection"
    output Integer gear;
    annotation (
      Documentation(info="This connector is an output from any transmission shifting
model.
"));
  end GearSelectorOutput;

  connector GearSelectorInput "Gear selection input for transmissions"
    input Integer gear;
    annotation (
      Documentation(info="This connectoris used as an input for transmissions.  The connector
contains information about what gear the transmission should be in.
"));
  end GearSelectorInput;

  partial model Transmission "Transmission Interface"
    Interfaces.GearSelectorInput gear_selector annotation (Placement(
          transformation(
          origin={0,110},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a driveline annotation (Placement(
          transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b engine annotation (Placement(
          transformation(extent={{90,-10},{110,10}})));
    annotation (
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
  public
    Interfaces.GearSelectorOutput gear_request annotation (Placement(
          transformation(
          origin={0,-110},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a wheel annotation (Placement(
          transformation(extent={{-110,-10},{-90,10}})));
  equation
    kph = der(wheel.phi)*tire_radius*60*60/1000;
    wheel.tau = 0;
    annotation (
      Icon(graphics={
          Ellipse(
            extent={{-80,80},{0,0}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-74,20},{-40,40}}, color={0,0,0}),
          Line(points={{-80,40},{-40,40}}, color={0,0,0}),
          Line(points={{-74,60},{-40,40}}, color={0,0,0}),
          Line(points={{-60,74},{-40,40}}, color={0,0,0}),
          Line(points={{-40,80},{-40,42}}, color={0,0,0}),
          Line(points={{-20,74},{-40,40}}, color={0,0,0}),
          Line(points={{-6,60},{-40,40}}, color={255,0,0}),
          Line(points={{0,40},{-40,40}}, color={255,0,0}),
          Ellipse(
            extent={{-70,70},{-10,10}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-40,40},{-60,60}}, color={0,0,0}),
          Polygon(
            points={{-60,60},{-58,52},{-52,58},{-60,60}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-38,42},{-42,38}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-90,0},{-40,0}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{0,40},{0,-100}},
            color={127,0,255},
            thickness=0.5),
          Text(extent={{-80,-20},{80,-80}}, textString=
                                                "%name")}),
      Documentation(info="This is the basic interface for any shift strategy model.  It connects to the
axle of the car and, using the tire radius, computes the vehicles translational
speed. This speed is then used to determine the appropriate gear which is then
assigned to the output gear selector.
"));
  end ShiftStrategy;

  partial model Chassis "Generic chassis interface"

    Modelica.Mechanics.Translational.Interfaces.Flange_a road "Road contact"
      annotation (Placement(transformation(extent={{-50,-110},{-30,
              -90}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a power "Driveline"
      annotation (Placement(transformation(extent={{70,-10},{90,10}})));
    Modelica.Blocks.Interfaces.RealOutput speed annotation (Placement(
          transformation(
          origin={60,-110},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a wheel annotation (Placement(
          transformation(extent={{-30,-70},{-10,-50}})));
    annotation (
      Documentation(info="This chassis interface has connections for the driveline side of the transmission, the wheels, road and a vehicle speed output.
This interface can be used as the constraining type in a replaceable declaration to allow easy substitution of chassis models."));
  end Chassis;

  partial model Cylinder
    Modelica.Mechanics.Rotational.Interfaces.Flange_a crankshaft annotation (Placement(
          transformation(extent={{-10,-208},{10,-188}})));
    Interfaces.Gas intake annotation (Placement(transformation(extent=
             {{-110,70},{-90,90}})));
    Interfaces.Gas exhaust annotation (Placement(transformation(
            extent={{90,70},{110,90}})));
    Interfaces.EngineGeometryRequired geom annotation (Placement(
          transformation(extent={{120,-60},{100,-40}})));
  end Cylinder;

  partial model Engine "Generic engine interface"
    Modelica.Mechanics.Rotational.Interfaces.Flange_a crankshaft annotation (Placement(
          transformation(extent={{-110,-50},{-90,-30}})));
    Interfaces.Gas intake annotation (Placement(transformation(extent=
             {{-110,70},{-90,90}})));
    Interfaces.Gas exhaust annotation (Placement(transformation(
            extent={{90,70},{110,90}})));
    Interfaces.EngineGeometryRequired engine_geometry annotation (Placement(
          transformation(
          origin={110,0},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    annotation (
      Documentation(info="This generic engine interface includes a connection for the crankshaft, the intake system, the exhause system and an input
for engine geometry information.  This interface can be used as the constraining type on replaceable declaration to allow
easy substitution of engine models.
"));
  end Engine;
  annotation (
    Documentation(info="This package contains numerous connector definitions and a few partial model
definitions for the major vehicle subsystems.
"));
end Interfaces;
