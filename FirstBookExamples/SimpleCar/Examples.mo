within FirstBookExamples.SimpleCar;
package Examples "A set of examples to demonstrate the 'SimpleCar' package"
  extends Modelica.Icons.Example;

  model Race "Race a car from 0-100 kilometers per hour"
    extends Modelica.Icons.Example;
    Vehicles.SportsCar sports_car annotation (Placement(
          transformation(extent={{-60,-40},{40,60}}, rotation=0)));
    Chassis.Road race_track annotation (Placement(transformation(
            extent={{-50,-100},{-10,-60}}, rotation=0)));
  equation
    connect(race_track.road_surface, sports_car.road) annotation (Line(
          points={{-30,-60},{-30,-40}}, color={0,255,0}));
    when (sports_car.speed.signal[1] > 100) then
      terminate("Simulation from 0-100 kilometers per hour completed");
    end when;
    annotation (
      Diagram(graphics),
      Documentation(info="This example allows you to study the effects of various vehicle/transmission/engine parameters.
The simulation will automatically stop once the vehicle has reached 100 kilometers per hour unless a shorter
simulation time is specified.
"));
  end Race;

  model CylinderOnDyno "Single cylinder engine connected to a dynamometer"
    extends Modelica.Icons.Example;
    Engine.Components.Reservoir intake(P=50000) annotation (Placement(
          transformation(extent={{-60,60},{-40,80}}, rotation=0)));
    Engine.Components.Reservoir exhaust annotation (Placement(
          transformation(extent={{40,60},{60,80}}, rotation=0)));
    Engine.Components.IndividualCylinder cylinder(
      spark_advance=20,
      burn_duration=60,
      evo=40,
      ivo=150,
      evc=205,
      ivc=310,
      combustion_chamber) annotation (Placement(transformation(extent
            ={{-20,-20},{20,40}}, rotation=0)));
    Engine.Components.Dynamometer dyno annotation (Placement(
          transformation(extent={{-40,-70},{-20,-50}}, rotation=0)));
    Modelica.Blocks.Sources.Ramp speed_profile(
      height={3000},
      duration={5},
      offset={1500},
      startTime={2}) annotation (Placement(transformation(extent={{
              -80,-70},{-60,-50}}, rotation=0)));
    Engine.GeometrySource sample_geometry(
      bore=0.08,
      stroke=0.08,
      conrod=0.152,
      comp_ratio=9.5) annotation (Placement(transformation(extent={{
              60,0},{80,20}}, rotation=0)));
  equation
    connect(cylinder.exhaust, exhaust.tap) annotation (Line(points={{
            20,36},{50,36},{50,60}}, color={255,127,0}));
    connect(cylinder.intake, intake.tap) annotation (Line(points={{
            -20,36},{-50,36},{-50,60}}, color={255,127,0}));
    connect(dyno.shaft, cylinder.crankshaft) annotation (Line(points=
            {{-20,-60},{0,-60},{1.11022e-15,-19.6}}, color={160,160,
            164}));
    connect(speed_profile.y, dyno.rpm) annotation (Line(points={{-59,
            -60},{-41,-60}}));
    connect(sample_geometry.geom, cylinder.geom) annotation (Line(
          points={{59,10},{22,10}}, color={0,0,0}));
    annotation (
      Documentation(info="This simulation involves a single cylinder connected
to a dynamometer.  One interesting thing to look at
in this simulation is the instantaneous torque felt
by the dynamometer vs. the average torque.  Both are
available as variables to be viewed within the dynamometer
model.
"));
  end CylinderOnDyno;

  model CylinderAndInertia "Single cylinder engine connected to a flywheel"
    extends Modelica.Icons.Example;
    Engine.Components.Reservoir intake(P=50000) annotation (Placement(
          transformation(extent={{-60,60},{-40,80}}, rotation=0)));
    Engine.Components.Reservoir exhaust annotation (Placement(
          transformation(extent={{40,60},{60,80}}, rotation=0)));
    Engine.Components.IndividualCylinder cylinder1(spark_advance=20,
        burn_duration=60) annotation (Placement(transformation(extent
            ={{-20,-20},{20,40}}, rotation=0)));
    Engine.GeometrySource sample_geometry(
      bore=0.08,
      stroke=0.08,
      conrod=0.152,
      comp_ratio=9.5) annotation (Placement(transformation(extent={{
              60,0},{80,20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia flywheel(J=10)
      annotation (Placement(transformation(extent={{-40,-70},{-20,-50}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque starter(useSupport=
          false) annotation (Placement(transformation(extent={{-68,
              -70},{-48,-50}}, rotation=0)));
    Modelica.Blocks.Sources.Step starter_torque(height={100}, startTime={1})
      annotation (Placement(transformation(extent={{-100,-70},{-80,
              -50}}, rotation=0)));
  equation
    connect(cylinder1.exhaust, exhaust.tap) annotation (Line(points={
            {20,36},{50,36},{50,60}}, color={255,127,0}));
    connect(cylinder1.intake, intake.tap) annotation (Line(points={{
            -20,36},{-50,36},{-50,60}}, color={255,127,0}));
    connect(sample_geometry.geom, cylinder1.geom) annotation (Line(
          points={{59,10},{22,10}}, color={0,0,0}));
    connect(flywheel.flange_b, cylinder1.crankshaft) annotation (Line(
          points={{-20,-60},{0,-60},{1.11022e-15,-19.6}}, color={160,
            160,164}));
    connect(starter_torque.y, starter.u) annotation (Line(points={{
            -79,-60},{-70,-60}}));
    connect(starter.flange, flywheel.flange_a)
      annotation (Line(points={{-48,-60},{-40,-60}}));
    annotation (
      Diagram(graphics),
      Documentation(info="This is a simulation of a single cylinder engine connected to a
flywheel.  The idea is to see the acceleration of the flywheel.
This is in contrast to other models where dynamometers are used
to keep the speed fixed.
"));
  end CylinderAndInertia;

  model I4EngineOnDyno "I4 engine connected to a dynamometer"
    extends Modelica.Icons.Example;
    Engine.Components.Dynamometer dyno annotation (Placement(
          transformation(extent={{-100,-76},{-60,-36}}, rotation=0)));
    Modelica.Blocks.Sources.Ramp speed_profile(
      height={3000},
      duration={5},
      offset={1500},
      startTime={2}) annotation (Placement(transformation(extent={{
              -140,-66},{-120,-46}}, rotation=0)));
    Engine.Components.Reservoir intake(P=101800) annotation (Placement(
          transformation(extent={{-60,60},{-20,100}}, rotation=0)));
    Engine.Components.Reservoir exhaust annotation (Placement(
          transformation(extent={{20,20},{60,60}}, rotation=0)));
    Engine.SportsCarGeometry sample_geometry(
      bore=0.08,
      stroke=0.08,
      conrod=0.152,
      comp_ratio=9.5) annotation (Placement(transformation(extent={{
              60,-60},{100,-20}}, rotation=0)));
    Engine.Components.I4_Engine I4(
      spark_advance=20,
      burn_duration=60,
      evo=64) annotation (Placement(transformation(extent={{-40,-80},
              {40,0}}, rotation=0)));
    Engine.Components.Manifold intake_manifold annotation (Placement(
          transformation(extent={{-60,8},{-20,48}}, rotation=0)));
    Modelica.Blocks.Sources.Constant throttle_angle(k={90}) annotation (Placement(
          transformation(extent={{-140,18},{-120,38}}, rotation=0)));
  equation
    connect(I4.engine_geometry, sample_geometry.geom) annotation (Line(
          points={{44,-40},{59,-40}}));
    connect(I4.exhaust, exhaust.tap) annotation (Line(points={{40,-8},
            {40,6},{40,20}}, color={255,127,0}));
    connect(dyno.shaft, I4.crankshaft) annotation (Line(points={{-60,
            -56},{-40,-56}}, color={160,160,164}));
    connect(intake_manifold.ambient, intake.tap) annotation (Line(
          points={{-40,48},{-40,60}}, color={255,127,0}));
    connect(intake_manifold.manifold, I4.intake) annotation (Line(
          points={{-40,8},{-40,-8}}, color={255,127,0}));
    connect(throttle_angle.y, intake_manifold.throttle_angle)
      annotation (Line(points={{-119,28},{-61.5,28}}));
    connect(speed_profile.y, dyno.rpm) annotation (Line(points={{-120,
            -56},{-102,-56}}));
    annotation (
      Documentation(info="This is a simulation of an I4 engine connected to a dynamometer.  The interesting
thing about this simulation that sets it apart from the single cylinder case is
that this model will demonstrate manifold filling and emptying effects.
"));
  end I4EngineOnDyno;

  model I4EngineAndInertia "I4 engine connected to a flywheel"
    extends Modelica.Icons.Example;
    Engine.Components.I4_Engine engine(spark_advance=20, burn_duration=60)
      annotation (Placement(transformation(extent={{40,-36},{60,-16}},
            rotation=0)));
    Engine.GeometrySource geometry(
      bore=0.080,
      stroke=0.080,
      conrod=0.157) annotation (Placement(transformation(extent={{80,
              -36},{100,-16}}, rotation=0)));
    Engine.Components.Reservoir intake_manifold annotation (Placement(
          transformation(extent={{20,0},{40,20}}, rotation=0)));
    Engine.Components.Reservoir exhaust_manifold annotation (Placement(
          transformation(extent={{60,0},{80,20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia flywheel(J=10, w(
          start=157)) annotation (Placement(transformation(extent={{0,
              -40},{20,-20}}, rotation=0)));
  equation
    connect(geometry.geom, engine.engine_geometry) annotation (Line(
          points={{79,-26},{61,-26}}, color={0,0,0}));
    connect(exhaust_manifold.tap, engine.exhaust) annotation (Line(
          points={{70,-5.55112e-16},{70,-18},{60,-18}}, color={255,
            127,0}));
    connect(intake_manifold.tap, engine.intake) annotation (Line(
          points={{30,-5.55112e-16},{30,-18},{40,-18}}, color={255,
            127,0}));
    connect(flywheel.flange_b, engine.crankshaft) annotation (Line(
          points={{20,-30},{40,-30}}, color={128,128,128}));
    annotation (
      Documentation(info="This model simulates an I4 engine accelerating an inertia.
"));
  end I4EngineAndInertia;
  annotation (
    Documentation(info="This package contains several example models that
demonstrate the component and subsystem models
found in the 'SimpleCar' package.  Each of the examples
includes some documentation on how the examples
should be used.
"));
end Examples;
