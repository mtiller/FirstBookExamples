within FirstBookExamples.Chapter7;
model SensorBenchmark
  import Modelica.Mechanics.Rotational;
  import Modelica.Blocks;

  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.8)
    annotation (Placement(transformation(extent={{50,30},{70,50}})));
  Modelica.Mechanics.Rotational.Components.Fixed ground annotation (
      Placement(transformation(extent={{70,-30},{90,-10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=0.2)
    annotation (Placement(transformation(
        origin={80,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Sources.Torque actuator(useSupport=
        false) annotation (Placement(transformation(extent={{12,30},{
            32,50}})));
  replaceable Rotational.Sensors.SpeedSensor sensor constrainedby
    Modelica.Mechanics.Rotational.Interfaces.PartialAbsoluteSensor
    annotation (Placement(transformation(
        origin={40,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Blocks.Continuous.PI controller(k=100, T=0.1)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Blocks.Math.Feedback feedback annotation (Placement(transformation(
          extent={{-50,30},{-30,50}})));
  Blocks.Sources.Trapezoid ref(
    amplitude=50,
    rising=0.2,
    width=0.25,
    falling=0.2,
    offset=50,
    period=1)       annotation (Placement(transformation(extent={{-90,30},
            {-70,50}})));
equation
  connect(ground.flange, damper.flange_b)
    annotation (Line(points={{80,-20},{80,-20},{80,-10}}));
  connect(actuator.flange, inertia.flange_a)
    annotation (Line(points={{32,40},{50,40}}));
  connect(sensor.flange, inertia.flange_a)
    annotation (Line(points={{40,10},{40,40},{50,40}}));
  connect(controller.y, actuator.tau)
    annotation (Line(points={{1,40},{10,40}}, color={0,0,127}));
  connect(feedback.y, controller.u) annotation (Line(points={{-31,40},
          {-26,40},{-22,40}}, color={0,0,127}));
  connect(ref.y, feedback.u1) annotation (Line(points={{-69,40},{
          -58.5,40},{-48,40}}, color={0,0,127}));
  connect(feedback.u2, sensor.w) annotation (Line(points={{-40,32},{
          -40,32},{-40,-20},{40,-20},{40,-11}}, color={0,0,127}));
  connect(inertia.flange_b, damper.flange_a) annotation (Line(points=
          {{70,40},{80,40},{80,10}}, color={0,0,0}));
end SensorBenchmark;
