within FirstBookExamples.SimpleCar;
package Chassis "A collection of chassis models and related components"
  extends Modelica.Icons.Package;
  model GenericCar "Generic car assembly"
    extends Interfaces.Chassis;
    parameter Modelica.SIunits.Mass vehicle_mass=1200 "Vehicle curb weight";
    parameter Real final_drive_ratio=3.43 "Final drive ratio";
    Types.KilometersPerHour kmh "Vehicle speed";
    Modelica.Mechanics.Rotational.Components.IdealGear final_drive(
        final ratio=final_drive_ratio, useSupport=false) annotation (
        Placement(transformation(
          origin={40,0},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    Chassis.Tire tire annotation (Placement(transformation(extent={{
              -60,-20},{-20,20}})));
    Modelica.Mechanics.Translational.Components.Mass vehicle_inertia(
        final m=vehicle_mass) annotation (Placement(transformation(
            extent={{-20,20},{20,60}})));
  equation
    connect(tire.body_force, vehicle_inertia.flange_a) annotation (Line(
          points={{-40,20},{-40,40},{-20,40}}, color={0,255,0}));
    connect(tire.road_force, road) annotation (Line(points={{-40,-20},
            {-40,-100}}, color={0,255,0}));
    connect(final_drive.flange_b, tire.axle) annotation (Line(points=
            {{30,1.83187e-15},{-20,1.11022e-15}}));
    connect(final_drive.flange_a, power) annotation (Line(points={{50,
            -7.21645e-16},{80,0}}));
    kmh = der(vehicle_inertia.flange_a.s)*3.6;
    speed = kmh;
    annotation (
      Icon(graphics={
          Polygon(
            points={{-62,-40},{80,-40},{74,-22},{58,-16},{36,-12},{18,
                6},{-30,6},{-40,-12},{-72,-20},{-72,-36},{-62,-40}},
            lineColor={0,0,0},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-52,-28},{-28,-52}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-50,-30},{-30,-50}},
            lineColor={0,0,0},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{48,-28},{72,-52}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{50,-30},{70,-50}},
            lineColor={0,0,0},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{16,2},{30,-12},{10,-12},{-4,-12},{-4,2},{16,2}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-74,-30},{-64,-36}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{54,-34},{66,-46}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-46,-34},{-34,-46}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-12,2},{-12,-12},{-34,-12},{-28,0},{-26,2},{-20,
                2},{-12,2}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(points={{-6,4},{-6,-32},{24,-32},{32,-26},{32,-12},
                {16,4},{-6,4}}, lineColor={128,128,128}),
          Line(points={{-40,-40},{-40,-100}}, color={127,255,0}),
          Text(extent={{-60,40},{60,20}}, textString=
                                              "%name")}),
      Documentation(info="This model contains the primitives necessary to
model the chassis of a car.  This is a very simple model
with only a single inertia and not compliances in the
car frame.
"));
  end GenericCar;

  model Tire "Tire model"
    parameter Modelica.SIunits.Radius tire_radius=0.35
                                                      "Tire radius";
  protected
    Modelica.SIunits.Position s_rel "Relative speed between chassis and road";

  public
    Modelica.Mechanics.Translational.Interfaces.Flange_a road_force
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a axle annotation (Placement(
          transformation(extent={{90,-10},{110,10}})));
    Modelica.Mechanics.Translational.Interfaces.Flange_b body_force
      annotation (Placement(
          transformation(extent={{-10,90},{10,110}})));
  equation
    road_force.f = axle.tau/tire_radius;
    road_force.f + body_force.f = 0;
    //  road_force.s = body_force.s;
    s_rel = axle.phi*tire_radius;
    body_force.s = road_force.s + s_rel;
    annotation (
      Icon(graphics={
          Rectangle(
            extent={{90,10},{54,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Ellipse(
            extent={{-60,60},{60,-60}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="This tire model connects to a driven axle as well as the
vehicle chassis and the road.  The rotational velocity
of the axle is used to compute the relative translational
velocity between the road and the vehicle chassis based on
the tire radius.
"));
  end Tire;

  model Road
    Modelica.Mechanics.Translational.Interfaces.Flange_a road_surface
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  equation
    road_surface.s = 0;
    annotation (
      Icon(graphics={
          Rectangle(
            extent={{-100,60},{100,-60}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-80,4},{-40,-6}},
            lineColor={255,255,0},
            pattern=LinePattern.None,
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-20,4},{20,-6}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{40,4},{80,-6}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,54},{100,46}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,-48},{100,-56}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,100},{0,60}}, color={0,255,0}),
          Text(extent={{-60,-60},{60,-100}}, textString=
                                                 "%name")}));
  end Road;

  model SportsCarChassis "Sports Car Chassis"
    extends Chassis.GenericCar(vehicle_mass=1250, final_drive_ratio=3.45);
  equation
    connect(final_drive.flange_b, wheel) annotation (Line(points={{30,
            1.83187e-15},{30,-60},{-20,-60}}));
    annotation (
      Documentation(info="This model extends the generic car chassis with the physical
characteristics of the Ford Mustang.
"));
  end SportsCarChassis;
  annotation (
    Documentation(info="This package contains all the chassis models and chassis component models
for the 'SimpleCar' package.  Some of the physical characteristics in this
package were found in the Bosch Automotive Handbook, 3rd Edition.
"), Icon(graphics={
        Ellipse(
          extent={{-55,-36},{-35,-56}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-51,-40},{-39,-52}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{44,-35},{64,-55}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{48,-39},{60,-51}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-68,-67},{-45,-46}}, color={0,0,0}),
        Line(points={{31,-66},{54,-45}}, color={0,0,0}),
        Line(
          points={{-48,-50},{51,-50},{35,-63},{-64,-63},{-48,-50}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-80,-57},{-60,-77}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-75,-61},{-63,-73}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{21,-57},{41,-77}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{25,-61},{37,-73}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}));
end Chassis;
