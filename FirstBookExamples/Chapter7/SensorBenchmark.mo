within FirstBookExamples.Chapter7;
model SensorBenchmark
  import Modelica.Mechanics.Rotational;
  import Modelica.Blocks;

  Rotational.Inertia inertia(J=0.8) annotation (extent=[50, 28; 70, 48]);
  Rotational.Fixed ground annotation (extent=[72, -38; 92, -18]);
  Rotational.Damper damper(d=0.2)
    annotation (extent=[72, -12; 92, 8], rotation=270);
  Rotational.Torque actuator annotation (extent=[18, 28; 38, 48]);
  replaceable Rotational.Sensors.SpeedSensor sensor constrainedby
    Rotational.Interfaces.AbsoluteSensor
    annotation (extent=[34, -10; 54, 10], rotation=270);
  Blocks.Continuous.PI controller(k={100}, T={0.1})
    annotation (extent=[-22, 28; -2, 48]);
  Blocks.Math.Feedback feedback annotation (extent=[-56, 28; -36, 48]);
  Blocks.Sources.Trapezoid ref(
    offset={50},
    rising={0.2},
    width={0.25},
    falling={0.2},
    amplitude={50}) annotation (extent=[-92, 28; -72, 48]);
equation
  connect(ground.flange_b, damper.flange_b)
    annotation (points=[82, -28; 82, -12]);
  connect(damper.flange_a, inertia.flange_b)
    annotation (points=[82, 8; 82, 38; 70, 38]);
  connect(actuator.flange_b, inertia.flange_a)
    annotation (points=[38, 38; 50, 38]);
  connect(sensor.flange_a, inertia.flange_a)
    annotation (points=[44, 10; 44, 38; 50, 38]);
  connect(controller.outPort, actuator.inPort)
    annotation (points=[-1, 38; 16, 38]);
  connect(feedback.outPort, controller.inPort)
    annotation (points=[-37, 38; -24, 38]);
  connect(sensor.outPort, feedback.inPort2)
    annotation (points=[44, -11; 44, -27.5; -46, -27.5; -46, 30]);
  connect(ref.outPort, feedback.inPort1) annotation (points=[-71, 38; -54, 38]);
end SensorBenchmark;
