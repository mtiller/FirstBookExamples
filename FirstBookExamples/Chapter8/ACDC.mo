within FirstBookExamples.Chapter8;
model ACDC "AC to DC power supply"
  extends FirstBookExamples.Icons.RunnableExample;
  Modelica.Electrical.Analog.Basic.Resistor leak(R=10e+6)
    annotation (Placement(transformation(
        origin={10,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-180,-60},{-160,-40}},
          rotation=0)));
  Modelica.Electrical.Analog.Sources.SineVoltage voltage(V=120, freqHz=60)
    annotation (Placement(transformation(
        origin={-170,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode
    annotation (Placement(transformation(extent={{-60,10},{-40,30}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=1e-4)
    annotation (Placement(transformation(
        origin={40,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor short(R=1e-5)
    annotation (Placement(transformation(extent={{-30,10},{-10,30}},
          rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealTransformer transformer(n=22)
    annotation (Placement(transformation(
        origin={-105,0},
        extent={{35,-40},{-35,40}},
        rotation=180)));
  Modelica.Electrical.Analog.Ideal.IdealSwitch switch(Gon=0)
    annotation (Placement(transformation(extent={{110,30},{130,10}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor load(R=3000)
    annotation (Placement(transformation(
        origin={140,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanPulse load_switch(period={0.5})
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0)));
equation
  connect(load.p, switch.n) annotation (Line(points={{140,10},{140,20},
          {130,20}}));
  connect(ground.p, voltage.p) annotation (Line(points={{-170,-40},{
          -170,-10}}));
  connect(capacitor.p, leak.p)
    annotation (Line(points={{40,10},{40,20},{10,20},{10,10}}));
  connect(short.n, leak.p) annotation (Line(points={{-10,20},{10,20},
          {10,10}}));
  connect(switch.p, short.n) annotation (Line(points={{110,20},{-10,
          20}}));
  connect(transformer.p1, ground.p)
    annotation (Line(points={{-140,-20},{-170,-20},{-170,-40}}));
  connect(voltage.n, transformer.n1)
    annotation (Line(points={{-170,10},{-170,20},{-140,20}}));
  connect(leak.n, transformer.p2)
    annotation (Line(points={{10,-10},{10,-20},{-70,-20}}));
  connect(capacitor.n, leak.n)
    annotation (Line(points={{40,-10},{40,-20},{10,-20},{10,-10}}));
  connect(load.n, capacitor.n)
    annotation (Line(points={{140,-10},{140,-20},{40,-20},{40,-10}}));
  connect(ground.p, transformer.p2)
    annotation (Line(points={{-170,-40},{-70,-40},{-70,-20}}));
  connect(load_switch.y, switch.control)
    annotation (Line(points={{101,5.55112e-16},{120,0},{120,14}},
        color={255,0,255}));
  connect(transformer.n2, diode.p) annotation (Line(points={{-70,20},
          {-60,20}}));
  connect(diode.n, short.p) annotation (Line(points={{-40,20},{-30,20}}));
  annotation (
    experiment(StopTime=1),
      Commands(file="ACDC.mos" "Simulate ACDC"),
    Diagram(graphics={
        Rectangle(
          extent={{-190,52},{60,-60}},
          lineColor={192,192,192},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{-120,72},{-20,52}},
          lineColor={0,0,0},
          textString=
               "Power Supply"),
        Rectangle(
          extent={{70,52},{160,-60}},
          lineColor={192,192,192},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{72,72},{160,52}},
          lineColor={0,0,0},
          textString=
               "Load Device"),
        Text(
          extent={{8,44},{42,34}},
          lineColor={0,0,0},
          textString=
               "supply"),
        Text(
          extent={{4,52},{18,38}},
          lineColor={0,0,0},
          textString=
               "V"),
        Ellipse(
          extent={{8,22},{12,18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{132,52},{146,38}},
          lineColor={0,0,0},
          textString=
               "V"),
        Text(
          extent={{140,44},{160,34}},
          lineColor={0,0,0},
          textString=
               "load"),
        Ellipse(
          extent={{138,22},{142,18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{10,38},{10,24}}, color={0,0,0}),
        Line(points={{140,24},{140,38}}, color={0,0,0})}));
end ACDC;
