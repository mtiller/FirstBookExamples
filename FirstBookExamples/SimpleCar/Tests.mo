within FirstBookExamples.SimpleCar;
package Tests "Models to test various models"
  extends Modelica.Icons.ExamplesPackage;

  model SingleControlVolume "Test a single control volume"
    extends Modelica.Icons.Example;
    Engine.Components.ControlVolume control_volume annotation (Placement(
          transformation(extent={{20,-20},{60,20}})));
    Modelica.Blocks.Sources.Sine volume(amplitude=0.25, offset=1)
      annotation (Placement(transformation(extent={{-60,-80},{-20,-40}})));
  equation
    connect(volume.y, control_volume.volume) annotation (Line(points=
            {{-18,-60},{80,-60},{80,0},{62,1.11022e-15}}));
    annotation (
      Documentation(info="This model looks at what happens to the states inside a control volume when the volume is change sinusoidally
(closely approximating the volume change in a combustion chamber).
"));
  end SingleControlVolume;

  model TestValve "Test an engine valve"
    extends Modelica.Icons.Example;
    Engine.Components.Reservoir upstream annotation (Placement(
          transformation(extent={{-75,34},{-55,54}})));
    Engine.Components.Valve valve annotation (Placement(
          transformation(extent={{-23,17},{-3,37}})));
    Engine.Components.ControlVolume control_volume annotation (Placement(
          transformation(extent={{-23,-25},{-3,-5}})));
    Modelica.Blocks.Sources.Constant volume(k=0.004)   annotation (Placement(
          transformation(extent={{-23,-55},{-3,-35}})));
    Engine.Components.Cam cam annotation (Placement(transformation(
            extent={{-44,69},{-24,89}})));
    Modelica.Mechanics.Rotational.Components.Inertia camshaft(w(start=
           157)) annotation (Placement(transformation(extent={{-81,69},
              {-61,89}})));
  equation
    connect(volume.y, control_volume.volume) annotation (Line(points=
            {{-2,-45},{12,-45},{12,-15},{-2,-15}}));
    connect(cam.valve_lift, valve.lift) annotation (Line(points={{-24,
            79},{-13,79},{-13,37}}));
    connect(camshaft.flange_b, cam.camshaft) annotation (Line(points=
            {{-61,79},{-36.8,79}}));
    connect(upstream.tap, valve.a) annotation (Line(points={{-65,34},
            {-65,27},{-23,27}}, color={255,127,0}));
    connect(valve.b, control_volume.state) annotation (Line(points={{
            -13,17},{-13,-15}}, color={255,127,0}));
    annotation (
      Documentation(info=
            "This model exercises the valve model by opening and closing the valve (via a valvetrain cam)."));
  end TestValve;

  model TestTransmission "Test the transmission and shift control"
    extends Modelica.Icons.Example;
    Transmission.FiveSpeed transmission annotation (Placement(
          transformation(extent={{-40,-40},{20,20}})));
    Modelica.Mechanics.Rotational.Components.Inertia engine
      annotation (Placement(transformation(extent={{40,-20},{60,0}})));
    Modelica.Mechanics.Rotational.Components.Inertia driveline(J=100)
      annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
    Modelica.Mechanics.Rotational.Sources.Torque engine_torque(
        useSupport=false) annotation (Placement(transformation(extent={{50,50},
              {70,70}})));
    Modelica.Blocks.Sources.Ramp torque_profile(height=100)   annotation (Placement(
          transformation(extent={{10,50},{30,70}})));
    Modelica.Mechanics.Rotational.Components.Damper bearing(d=10)
      annotation (Placement(transformation(
          origin={-80,-30},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.Rotational.Components.Fixed mount annotation (
        Placement(transformation(extent={{-90,-70},{-70,-50}})));
    Transmission.SimpleShiftStrategy shift_strategy(tire_radius=0.35,
        up_shift_schedule={10,20,30,40}) annotation (Placement(
          transformation(extent={{-30,50},{10,90}})));
  equation
    connect(driveline.flange_b, transmission.driveline) annotation (Line(
          points={{-50,-10},{-40,-10}}, color={128,128,128}));
    connect(transmission.engine, engine.flange_a) annotation (Line(
          points={{20,-10},{40,-10}}, color={128,128,128}));
    connect(engine_torque.flange, engine.flange_b) annotation (Line(
          points={{70,60},{80,60},{80,-10},{60,-10}}, color={128,128,
            128}));
    connect(driveline.flange_a, bearing.flange_b) annotation (Line(
          points={{-70,-10},{-80,-10},{-80,-20}}, color={128,128,128}));
    connect(bearing.flange_a, mount.flange) annotation (Line(points={
            {-80,-40},{-80,-60}}, color={128,128,128}));
    connect(shift_strategy.gear_request, transmission.gear_selector)
      annotation (Line(points={{-10,48},{-10,23}}, color={127,0,255}));
    connect(transmission.driveline, shift_strategy.wheel) annotation (Line(
          points={{-40,-10},{-40,70},{-30,70}}, color={128,128,128}));
    connect(torque_profile.y, engine_torque.tau) annotation (Line(
          points={{31,60},{39.5,60},{48,60}}, color={0,0,127}));
    annotation (
      Documentation(info="This model tests the transmission and its control strategy by running the transmission
through a range of speeds such that all gears are engaged.
"));
  end TestTransmission;
  annotation (
    Documentation(info="The models in this package are used to verify that all the models are
working properly.  These models are not as interesting as the models
found in the 'Examples' package because they do not represent typical
or meaningful configurations of components.  Instead, these models
test the function of models by conducting virtual experiments on them
to validate the basics of their performance.
"));
end Tests;
