within FirstBookExamples.Chapter8;
model ACDC "AC to DC power supply"
  extends FirstBookExamples.Icons.RunnableExample;
  Modelica.Electrical.Analog.Basic.Resistor leak(R=10e+6)
    annotation (Placement(transformation(
        origin={20,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-170,-60},{-150,-40}})));
  Modelica.Electrical.Analog.Sources.SineVoltage voltage(V=120, freqHz=60)
    annotation (Placement(transformation(
        origin={-160,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=1e-4)
    annotation (Placement(transformation(
        origin={50,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor short(R=1e-5)
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Electrical.Analog.Ideal.IdealTransformer transformer(n=22,
    considerMagnetization=false,
    Lm1=1)
    annotation (Placement(transformation(
        origin={-95,7.10543e-15},
        extent={{35,-40},{-35,40}},
        rotation=180)));
  Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch
                                               switch(Goff=0)
    annotation (Placement(transformation(extent={{120,30},{140,10}})));
  Modelica.Electrical.Analog.Basic.Resistor load(R=3000)
    annotation (Placement(transformation(
        origin={150,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanPulse load_switch(period=0.5)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(load_switch.y, switch.control)
    annotation (Line(points={{111,5.55112e-16},{130,5.55112e-16},{130,
          13}},
        color={255,0,255}));
  connect(voltage.n, transformer.n1) annotation (Line(points={{-160,
          10},{-160,10},{-160,20},{-130,20}}, color={0,0,255}));
  connect(voltage.p, transformer.p1) annotation (Line(points={{-160,
          -10},{-160,-10},{-160,-20},{-130,-20}}, color={0,0,255}));
  connect(ground.p, voltage.p) annotation (Line(points={{-160,-40},{
          -160,-40},{-160,-10},{-160,-10}}, color={0,0,255}));
  connect(ground.p, transformer.p2) annotation (Line(points={{-160,
          -40},{-160,-40},{-160,-30},{-60,-30},{-60,-20}}, color={0,0,
          255}));
  connect(transformer.n2, diode.p)
    annotation (Line(points={{-60,20},{-50,20}}, color={0,0,255}));
  connect(short.p, diode.n)
    annotation (Line(points={{-20,20},{-30,20}}, color={0,0,255}));
  connect(leak.p, short.n) annotation (Line(points={{20,10},{20,20},{
          0,20}}, color={0,0,255}));
  connect(capacitor.p, short.n) annotation (Line(points={{50,10},{50,
          20},{0,20}}, color={0,0,255}));
  connect(switch.p, short.n)
    annotation (Line(points={{120,20},{0,20}}, color={0,0,255}));
  connect(switch.n, load.p) annotation (Line(points={{140,20},{150,20},
          {150,10}}, color={0,0,255}));
  connect(transformer.p2, leak.n) annotation (Line(points={{-60,-20},
          {20,-20},{20,-10}}, color={0,0,255}));
  connect(capacitor.n, leak.n) annotation (Line(points={{50,-10},{50,
          -20},{20,-20},{20,-10}}, color={0,0,255}));
  connect(load.n, leak.n) annotation (Line(points={{150,-10},{150,-20},
          {20,-20},{20,-10}}, color={0,0,255}));
  annotation (
    experiment(StopTime=1),
      __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter8/ACDC.mos" "Simulate ACDC"),
    Diagram(coordinateSystem(extent={{-200,-80},{200,80}}),
            graphics={
        Rectangle(
          extent={{-180,52},{70,-60}},
          lineColor={192,192,192},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{-110,72},{-10,52}},
          lineColor={0,0,0},
          textString=
               "Power Supply"),
        Rectangle(
          extent={{80,52},{170,-60}},
          lineColor={192,192,192},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{82,72},{170,52}},
          lineColor={0,0,0},
          textString=
               "Load Device"),
        Text(
          extent={{18,44},{52,34}},
          lineColor={0,0,0},
          textString=
               "supply"),
        Text(
          extent={{14,52},{28,38}},
          lineColor={0,0,0},
          textString=
               "V"),
        Ellipse(
          extent={{18,22},{22,18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{142,52},{156,38}},
          lineColor={0,0,0},
          textString=
               "V"),
        Text(
          extent={{150,44},{170,34}},
          lineColor={0,0,0},
          textString=
               "load"),
        Ellipse(
          extent={{148,22},{152,18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{20,38},{20,24}}, color={0,0,0}),
        Line(points={{150,24},{150,38}}, color={0,0,0})}),
    Icon(coordinateSystem(extent={{-200,-80},{200,80}})));
end ACDC;
