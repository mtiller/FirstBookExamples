within FirstBookExamples.Chapter7;
model SensorBenchmark
  import Modelica.Mechanics.Rotational;
  import Modelica.Blocks;

  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.8)
    annotation (Placement(transformation(extent={{50,28},{70,48}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Components.Fixed ground annotation (
      Placement(transformation(extent={{72,-38},{92,-18}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=0.2)
    annotation (Placement(transformation(
        origin={82,-2},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Sources.Torque actuator(useSupport=
        false) annotation (Placement(transformation(extent={{18,28},{
            38,48}}, rotation=0)));
  replaceable Rotational.Sensors.SpeedSensor sensor constrainedby
    Modelica.Mechanics.Rotational.Interfaces.PartialAbsoluteSensor
    annotation (Placement(transformation(
        origin={44,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Blocks.Continuous.PI controller(k={100}, T={0.1})
    annotation (Placement(transformation(extent={{-22,28},{-2,48}},
          rotation=0)));
  Blocks.Math.Feedback feedback annotation (Placement(transformation(
          extent={{-56,28},{-36,48}}, rotation=0)));
  Blocks.Sources.Trapezoid ref(
    offset={50},
    rising={0.2},
    width={0.25},
    falling={0.2},
    amplitude={50}) annotation (Placement(transformation(extent={{-92,
            28},{-72,48}}, rotation=0)));
equation
  connect(ground.flange, damper.flange_b)
    annotation (Line(points={{82,-28},{82,-12}}));
  connect(damper.flange_a, inertia.flange_b)
    annotation (Line(points={{82,8},{82,38},{70,38}}));
  connect(actuator.flange, inertia.flange_a)
    annotation (Line(points={{38,38},{50,38}}));
  connect(sensor.flange, inertia.flange_a)
    annotation (Line(points={{44,10},{44,38},{50,38}}));
  connect(controller.y, actuator.u)
    annotation (Line(points={{-1,38},{16,38}}));
  connect(feedback.y, controller.u)
    annotation (Line(points={{-37,38},{-24,38}}));
  connect(sensor.y, feedback.u2)
    annotation (Line(points={{44,-11},{44,-27.5},{-46,-27.5},{-46,30}}));
  connect(ref.y, feedback.u1) annotation (Line(points={{-71,38},{-54,
          38}}));
end SensorBenchmark;
