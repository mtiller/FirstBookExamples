package Tests "Models to test various models" 
  extends Modelica.Icons.Example;
  
  model SingleControlVolume "Test a single control volume" 
    extends Modelica.Icons.Example;
    Engine.Components.ControlVolume control_volume annotation (extent=[20, -20
          ; 60, 20]);
    Modelica.Blocks.Sources.Sine volume(amplitude={.25}, offset={1}) 
      annotation (extent=[-60, -80; -20, -40]);
  equation 
    connect(volume.outPort, control_volume.volume) annotation (points=[-18, 
          -60; 80, -60; 80, 0; 62, 1.11022e-15]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.17, 
        y=0.07, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This model looks at what happens to the states inside a control volume when the volume is change sinusoidally
(closely approximating the volume change in a combustion chamber).
"));
  end SingleControlVolume;
  model TestValve "Test an engine valve" 
    extends Modelica.Icons.Example;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.17, 
        y=0.23, 
        width=0.6, 
        height=0.6), 
      Documentation(info=
            "This model exercises the valve model by opening and closing the valve (via a valvetrain cam)."
        ));
    Engine.Components.Reservoir upstream annotation (extent=[-75, 34; -55, 54]
      );
    Engine.Components.Valve valve annotation (extent=[-23, 17; -3, 37]);
    Engine.Components.ControlVolume control_volume annotation (extent=[-23, -
          25; -3, -5]);
    Modelica.Blocks.Sources.Constant volume(k={0.004}) annotation (extent=[-23
          , -55; -3, -35]);
    Engine.Components.Cam cam annotation (extent=[-44, 69; -24, 89]);
    Modelica.Mechanics.Rotational.Inertia camshaft(w(start=157)) annotation (
        extent=[-81, 69; -61, 89]);
  equation 
    connect(volume.outPort, control_volume.volume) annotation (points=[-2, -
          45; 12, -45; 12, -15; -2, -15]);
    connect(cam.valve_lift, valve.lift) annotation (points=[-24, 79; -13, 79; 
          -13, 37]);
    connect(camshaft.flange_b, cam.camshaft) annotation (points=[-61, 79; -
          36.8, 79]);
    connect(upstream.tap, valve.a) annotation (points=[-65, 34; -65, 27; -23, 
          27], style(color=45));
    connect(valve.b, control_volume.state) annotation (points=[-13, 17; -13, -
          15], style(color=45));
  end TestValve;
  annotation (
    Coordsys(
      extent=[0, 0; 442, 384], 
      grid=[1, 1], 
      component=[20, 20]), 
    Window(
      x=0.45, 
      y=0.01, 
      width=0.35, 
      height=0.49, 
      library=1, 
      autolayout=1), 
    Documentation(info="The models in this package are used to verify that all the models are
working properly.  These models are not as interesting as the models
found in the 'Examples' package because they do not represent typical
or meaningful configurations of components.  Instead, these models
test the function of models by conducting virtual experiments on them
to validate the basics of their performance.
"));
  model TestTransmission "Test the transmission and shift control" 
    extends Modelica.Icons.Example;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.07, 
        y=0.16, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This model tests the transmission and its control strategy by running the transmission
through a range of speeds such that all gears are engaged.
"));
    Transmission.FiveSpeed transmission annotation (extent=[-40, -40; 20, 20])
      ;
    Modelica.Mechanics.Rotational.Inertia engine annotation (extent=[40, -20; 
          60, 0]);
    Modelica.Mechanics.Rotational.Inertia driveline(J=100) annotation (extent=
          [-70, -20; -50, 0]);
    Modelica.Mechanics.Rotational.Torque engine_torque annotation (extent=[50
          , 50; 70, 70]);
    Modelica.Blocks.Sources.Ramp torque_profile(height={100}) annotation (
        extent=[10, 50; 30, 70]);
    Modelica.Mechanics.Rotational.Damper bearing(d=10) annotation (extent=[-90
          , -40; -70, -20], rotation=90);
    Modelica.Mechanics.Rotational.Fixed mount annotation (extent=[-90, -70; -
          70, -50]);
    Transmission.SimpleShiftStrategy shift_strategy(tire_radius=0.35, 
        up_shift_schedule={10,20,30,40}) annotation (extent=[-30, 50; 10, 90]);
  equation 
    connect(driveline.flange_b, transmission.driveline) annotation (points=[
          -50, -10; -40, -10], style(color=10));
    connect(transmission.engine, engine.flange_a) annotation (points=[20, -10
          ; 40, -10], style(color=10));
    connect(engine_torque.flange_b, engine.flange_b) annotation (points=[70, 
          60; 80, 60; 80, -10; 60, -10], style(color=10));
    connect(torque_profile.outPort, engine_torque.inPort) annotation (points=[
          31, 60; 48, 60]);
    connect(driveline.flange_a, bearing.flange_b) annotation (points=[-70, -10
          ; -80, -10; -80, -20], style(color=10));
    connect(bearing.flange_a, mount.flange_b) annotation (points=[-80, -40; -
          80, -60], style(color=10));
    connect(shift_strategy.gear_request, transmission.gear_selector) 
      annotation (points=[-10, 48; -10, 23], style(color=77));
    connect(transmission.driveline, shift_strategy.wheel) annotation (points=[
          -40, -10; -40, 70; -30, 70], style(color=10));
  end TestTransmission;
end Tests;
