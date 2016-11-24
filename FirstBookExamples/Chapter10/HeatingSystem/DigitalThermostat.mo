within FirstBookExamples.Chapter10.HeatingSystem;
model DigitalThermostat
  parameter Modelica.SIunits.Temperature T_on(start=300);
  parameter Modelica.SIunits.Temperature T_off(start=305);
protected
  parameter Real tc_C[:]={4.5e-8,3.4e-6,2.3e-3};
public
  extends Thermostat;
  Thermal.MixedDomain.Thermocouple thermocouple(C=tc_C)
    annotation (Placement(transformation(
        origin={-10,60},
        extent={{-20,-20},{20,20}},
        rotation=180)));
  DigitalCircuit controller(
    T_on=T_on,
    T_off=T_off,
    tc_C=tc_C) annotation (Placement(transformation(extent={{-40,-40},
            {20,20}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
equation
  connect(thermal, thermocouple.node_a)
    annotation (Line(points={{-100,80},{-10,80}}, color={255,0,0}));
  connect(controller.ground, ground.p)
    annotation (Line(points={{8,-28},{40,-28},{40,-40}}));
  connect(controller.thermo_p, thermocouple.p)
    annotation (Line(points={{8,8},{20,8},{20,60},{10,60}}));
  connect(controller.thermo_n, thermocouple.n)
    annotation (Line(points={{-28,8},{-40,8},{-40,60},{-30,60}}));
  connect(controller.furnace_p, p)
    annotation (Line(points={{-28,-10},{-60,-10},{-60,0},{-100,0}}));
  connect(controller.furnace_n, n)
    annotation (Line(points={{-28,-28},{-60,-28},{-60,-80},{-100,-80}}));
  annotation (
    Diagram(graphics={Text(extent={{-32,-36},{14,-46}}, textString=
                                                    "controller")}),
    Icon(graphics={
        Rectangle(
          extent={{100,100},{-100,-100}},
          lineColor={0,0,0},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,80},{80,0}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-48,-26},{48,-74}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,-70},{-44,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{4,-30},{44,-70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,76},{76,4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-76,76},{34,4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "%T_on%"),
        Text(
          extent={{26,76},{68,4}},
          lineColor={0,0,0},
          textString=
               "K"),
        Line(points={{0,-30},{0,-70}}, color={128,128,128}),
        Polygon(
          points={{24,-40},{14,-60},{34,-60},{24,-40}},
          lineColor={255,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-34,-40},{-24,-60},{-14,-40},{-34,-40}},
          lineColor={28,108,200},
          fillColor={0,95,191},
          fillPattern=FillPattern.Solid)}));
end DigitalThermostat;
