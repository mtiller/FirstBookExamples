within FirstBookExamples.Thermal;
package Sensors
  extends Modelica.Icons.Package;
  model TemperatureSensor "Absolute temperature sensor"

    Modelica.Blocks.Interfaces.RealOutput T annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    Interfaces.Node_a n annotation (Placement(transformation(extent={
              {-110,-10},{-90,10}})));
  equation
    T = n.T;
    n.q = 0;

    annotation (
      Icon(graphics={
          Ellipse(
            extent={{-20,-98},{20,-60}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-12,40},{12,-68}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{12,0},{100,0}}),
          Line(points={{-90,0},{-12,0}}, color={255,0,0}),
          Line(
            points={{-12,52},{-22,52}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{-12,30},{-22,30}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{-12,70},{-22,70}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{-12,10},{-22,10}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{-12,-10},{-22,-10}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{-12,-30},{-22,-30}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{-12,-50},{-22,-50}},
            color={0,0,0},
            thickness=1),
          Polygon(
            points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},
                {10,86},{12,80},{12,40},{-12,40}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{-12,40},{-12,-64}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{12,40},{12,-64}},
            color={0,0,0},
            thickness=0.5),
          Text(extent={{-100,130},{100,90}}, textString=
                                                 "%name")}),
      Documentation(info="This is an ideal absolute temperature sensor.  The
sensor itself has not thermal interaction with
whatever it is connected to.  Furthermore, not
thermocouple-like lags are associated with this
sensor model.
"));
  end TemperatureSensor;

  model HeatFlow "Heat flow rate sensor"
    extends Modelica.Icons.RotationalSensor;
    Interfaces.Node_a a annotation (Placement(transformation(extent={
              {-110,-10},{-90,10}})));
    Interfaces.Node_b b annotation (Placement(transformation(extent={
              {90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.RealOutput heat "Heat flow from a->b" annotation (Placement(
          transformation(
          origin={0,-110},
          extent={{-10,-10},{10,10}},
          rotation=270)));
  equation
    a.q + b.q = 0;
    heat = a.q;
    a.T = b.T;
    annotation (
      Icon(graphics={
          Text(
            extent={{-22,-17},{22,-55}},
            lineColor={255,0,0},
            textString=
                 "q"),
          Line(points={{-70,0},{-90,0}}, color={255,0,0}),
          Line(points={{69,0},{90,0}}, color={255,0,0}),
          Line(points={{0,-70},{0,-100}}),
          Text(extent={{-100,110},{100,70}}, textString=
                                                 "%name")}),
      Documentation(info="This model is capable of monitoring the heat flow through a given thermal path.  The sensed value of heat
flow is the amount that passes through this sensor while keeping the temperature drop across the
sensor zero.  This is an ideal model so it does not absorb any energy and it has no direct effect on the
thermal response of a system it is included in.
"));
  end HeatFlow;
end Sensors;
