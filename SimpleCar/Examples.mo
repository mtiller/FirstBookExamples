package Examples "A set of examples to demonstrate the 'SimpleCar' package" 
  extends Modelica.Icons.Example;
  
  model Race "Race a car from 0-100 kilometers per hour" 
    extends Modelica.Icons.Example;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.32, 
        y=0.13, 
        width=0.6, 
        height=0.6), 
      Diagram, 
      Documentation(info="This example allows you to study the effects of various vehicle/transmission/engine parameters.
The simulation will automatically stop once the vehicle has reached 100 kilometers per hour unless a shorter
simulation time is specified.
"));
    Vehicles.SportsCar sports_car annotation (extent=[-60, -40; 40, 60]);
    Chassis.Road race_track annotation (extent=[-50, -100; -10, -60]);
  equation 
    connect(race_track.road_surface, sports_car.road) annotation (points=[-
          30, -60; -30, -40], style(color=57));
    when (sports_car.speed.signal[1] > 100) then
      terminate("Simulation from 0-100 kilometers per hour completed");
    end when;
  end Race;
  model CylinderOnDyno "Single cylinder engine connected to a dynamometer" 
    extends Modelica.Icons.Example;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.1, 
        y=0.21, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This simulation involves a single cylinder connected
to a dynamometer.  One interesting thing to look at
in this simulation is the instantaneous torque felt
by the dynamometer vs. the average torque.  Both are
available as variables to be viewed within the dynamometer
model.
"));
    Engine.Components.Reservoir intake(P=50000) annotation (extent=[-60, 60; -
          40, 80]);
    Engine.Components.Reservoir exhaust annotation (extent=[40, 60; 60, 80]);
    Engine.Components.IndividualCylinder cylinder(
      spark_advance=20, 
      burn_duration=60, 
      evo=40, 
      ivo=150, 
      evc=205, 
      ivc=310, 
      combustion_chamber) annotation (extent=[-20, -20; 20, 40]);
    Engine.Components.Dynamometer dyno annotation (extent=[-40, -70; -20, -50]
      );
    Modelica.Blocks.Sources.Ramp speed_profile(
      height={3000}, 
      duration={5}, 
      offset={1500}, 
      startTime={2}) annotation (extent=[-80, -70; -60, -50]);
    Engine.GeometrySource sample_geometry(
      bore=.08, 
      stroke=.08, 
      conrod=.152, 
      comp_ratio=9.5) annotation (extent=[60, 0; 80, 20]);
  equation 
    connect(cylinder.exhaust, exhaust.tap) annotation (points=[20, 36; 50, 
          36; 50, 60], style(color=45));
    connect(cylinder.intake, intake.tap) annotation (points=[-20, 36; -50, 36
          ; -50, 60], style(color=45));
    connect(dyno.shaft, cylinder.crankshaft) annotation (points=[-20, -60; 0, 
          -60; 1.11022e-15, -19.6], style(color=9));
    connect(speed_profile.outPort, dyno.rpm) annotation (points=[-59, -60; -41
          , -60]);
    connect(sample_geometry.geom, cylinder.geom) annotation (points=[59, 10; 
          22, 10], style(color=0));
  end CylinderOnDyno;
  annotation (
    Coordsys(
      extent=[0, 0; 432, 377], 
      grid=[1, 1], 
      component=[20, 20]), 
    Window(
      x=0.04, 
      y=0.32, 
      width=0.28, 
      height=0.42, 
      library=1, 
      autolayout=1), 
    Documentation(info="This package contains several example models that
demonstrate the component and subsystem models
found in the 'SimpleCar' package.  Each of the examples
includes some documentation on how the examples
should be used.
"));
  model CylinderAndInertia "Single cylinder engine connected to a flywheel" 
    extends Modelica.Icons.Example;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Diagram, 
      Window(
        x=0.32, 
        y=0.13, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This is a simulation of a single cylinder engine connected to a
flywheel.  The idea is to see the acceleration of the flywheel.
This is in contrast to other models where dynamometers are used
to keep the speed fixed.
"));
    Engine.Components.Reservoir intake(P=50000) annotation (extent=[-60, 60; -
          40, 80]);
    Engine.Components.Reservoir exhaust annotation (extent=[40, 60; 60, 80]);
    Engine.Components.IndividualCylinder cylinder1(spark_advance=20, 
        burn_duration=60) annotation (extent=[-20, -20; 20, 40]);
    Engine.GeometrySource sample_geometry(
      bore=.08, 
      stroke=.08, 
      conrod=.152, 
      comp_ratio=9.5) annotation (extent=[60, 0; 80, 20]);
    Modelica.Mechanics.Rotational.Inertia flywheel(J=10) annotation (extent=[-
          40, -70; -20, -50]);
    Modelica.Mechanics.Rotational.Torque starter annotation (extent=[-68, -70
          ; -48, -50]);
    Modelica.Blocks.Sources.Step starter_torque(height={100}, startTime={1}) 
      annotation (extent=[-100, -70; -80, -50]);
  equation 
    connect(cylinder1.exhaust, exhaust.tap) annotation (points=[20, 36; 50, 
          36; 50, 60], style(color=45));
    connect(cylinder1.intake, intake.tap) annotation (points=[-20, 36; -50, 36
          ; -50, 60], style(color=45));
    connect(sample_geometry.geom, cylinder1.geom) annotation (points=[59, 10; 
          22, 10], style(color=0));
    connect(flywheel.flange_b, cylinder1.crankshaft) annotation (points=[-20, 
          -60; 0, -60; 1.11022e-15, -19.6], style(color=9));
    connect(starter_torque.outPort, starter.inPort) annotation (points=[-79, -
          60; -70, -60]);
    connect(starter.flange_b, flywheel.flange_a) annotation (points=[-48, -60
          ; -40, -60]);
  end CylinderAndInertia;
  model I4EngineOnDyno "I4 engine connected to a dynamometer" 
    extends Modelica.Icons.Example;
    annotation (
      Coordsys(
        extent=[-150, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.32, 
        y=0.07, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This is a simulation of an I4 engine connected to a dynamometer.  The interesting
thing about this simulation that sets it apart from the single cylinder case is
that this model will demonstrate manifold filling and emptying effects.
"));
    Engine.Components.Dynamometer dyno annotation (extent=[-100, -76; -60, -36
          ]);
    Modelica.Blocks.Sources.Ramp speed_profile(
      height={3000}, 
      duration={5}, 
      offset={1500}, 
      startTime={2}) annotation (extent=[-140, -66; -120, -46]);
    Engine.Components.Reservoir intake(P=101800) annotation (extent=[-60, 60; 
          -20, 100]);
    Engine.Components.Reservoir exhaust annotation (extent=[20, 20; 60, 60]);
    Engine.SportsCarGeometry sample_geometry(
      bore=.08, 
      stroke=.08, 
      conrod=.152, 
      comp_ratio=9.5) annotation (extent=[60, -60; 100, -20]);
    Engine.Components.I4_Engine I4(
      spark_advance=20, 
      burn_duration=60, 
      evo=64) annotation (extent=[-40, -80; 40, 0]);
    Engine.Components.Manifold intake_manifold annotation (extent=[-60, 8; -20
          , 48]);
    Modelica.Blocks.Sources.Constant throttle_angle(k={90}) annotation (extent
        =[-140, 18; -120, 38]);
  equation 
    connect(I4.engine_geometry, sample_geometry.geom) annotation (points=[44
          , -40; 59, -40]);
    connect(I4.exhaust, exhaust.tap) annotation (points=[40, -8; 40, 6; 40, 20
          ], style(color=45));
    connect(dyno.shaft, I4.crankshaft) annotation (points=[-60, -56; -40, -56]
        , style(color=9));
    connect(intake_manifold.ambient, intake.tap) annotation (points=[-40, 48; 
          -40, 60], style(color=45));
    connect(intake_manifold.manifold, I4.intake) annotation (points=[-40, 8; -
          40, -8], style(color=45));
    connect(throttle_angle.outPort, intake_manifold.throttle_angle) 
      annotation (points=[-119, 28; -61.5, 28]);
    connect(speed_profile.outPort, dyno.rpm) annotation (points=[-120, -56; -
          102, -56]);
  end I4EngineOnDyno;
  model I4EngineAndInertia "I4 engine connected to a flywheel" 
    extends Modelica.Icons.Example;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.27, 
        y=0.1, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This model simulates an I4 engine accelerating an inertia.
"));
    Engine.Components.I4_Engine engine(spark_advance=20, burn_duration=60) 
      annotation (extent=[40, -36; 60, -16]);
    Engine.GeometrySource geometry(
      bore=0.080, 
      stroke=0.080, 
      conrod=0.157) annotation (extent=[80, -36; 100, -16]);
    Engine.Components.Reservoir intake_manifold annotation (extent=[20, 0; 40
          , 20]);
    Engine.Components.Reservoir exhaust_manifold annotation (extent=[60, 0; 80
          , 20]);
    Modelica.Mechanics.Rotational.Inertia flywheel(J=10, w(start=157)) 
      annotation (extent=[0, -40; 20, -20]);
  equation 
    connect(geometry.geom, engine.engine_geometry) annotation (points=[79, -
          26; 61, -26], style(color=0));
    connect(exhaust_manifold.tap, engine.exhaust) annotation (points=[70, -
          5.55112e-16; 70, -18; 60, -18], style(color=45));
    connect(intake_manifold.tap, engine.intake) annotation (points=[30, -
          5.55112e-16; 30, -18; 40, -18], style(color=45));
    connect(flywheel.flange_b, engine.crankshaft) annotation (points=[20, -30
          ; 40, -30], style(color=10));
  end I4EngineAndInertia;
end Examples;
