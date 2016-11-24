within FirstBookExamples.Chapter10.FactoryModels;
model ConveyorBelt
  import Modelica.Mechanics.Rotational;
  Rotational.Interfaces.Flange_a axle annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  replaceable Modelica.Mechanics.Rotational.Components.IdealGear
    gears(ratio=5, useSupport=false) constrainedby
    Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Mechanics.Rotational.Components.IdealGearR2T belt(
      useSupportR=false, useSupportT=false,
    ratio=1)                                annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Translational.Components.Mass product(m=1)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Mechanics.Rotational.Components.Fixed ground annotation (
      Placement(transformation(extent={{-30,-60},{-10,-40}})));
  Modelica.Mechanics.Rotational.Components.Damper bearings(d=20)
    annotation (Placement(transformation(
        origin={-20,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Components.Inertia shaft(J=0.3)
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
equation
  connect(gears.flange_a, axle) annotation (Line(points={{-80,0},{
          -100,0}}));
  connect(belt.flangeT, product.flange_a)
    annotation (Line(points={{10,0},{20,0}}));
  connect(bearings.flange_b, belt.flangeR)
    annotation (Line(points={{-20,-20},{-20,0},{-10,0}}));
  connect(bearings.flange_a, ground.flange)
    annotation (Line(points={{-20,-40},{-20,-50}}));
  connect(shaft.flange_b, belt.flangeR)
    annotation (Line(points={{-28,0},{-10,0}}));
  connect(gears.flange_b, shaft.flange_a) annotation (Line(points={{
          -60,0},{-48,0}}));
  annotation (
    Icon(graphics={
        Ellipse(
          extent={{-70,10},{-50,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={160,160,164}),
        Line(points={{-90,0},{-70,0}}, color={0,0,0}),
        Ellipse(
          extent={{50,10},{70,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={160,160,164}),
        Line(
          points={{-60,10},{60,10}},
          color={160,160,164},
          thickness=1),
        Line(
          points={{-60,-10},{60,-10}},
          color={160,160,164},
          thickness=1),
        Ellipse(
          extent={{-30,10},{-10,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={160,160,164}),
        Ellipse(
          extent={{10,10},{30,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={160,160,164}),
        Rectangle(
          extent={{-50,30},{-30,10}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,30},{50,10}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={191,95,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,30},{-30,10}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={191,95,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,30},{10,10}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={191,95,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,40},{-60,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,20},{-60,26}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,20},{-66,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{60,20},{80,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{74,40},{80,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{80,34},{80,40}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-64,4},{-56,-4}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{56,4},{64,-4}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,-2},{-60,-40}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-80,-40},{80,-40}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{60,0},{60,-40}},
          color={0,0,0},
          thickness=1),
        Rectangle(
          extent={{-80,-40},{80,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Forward)}));
end ConveyorBelt;
