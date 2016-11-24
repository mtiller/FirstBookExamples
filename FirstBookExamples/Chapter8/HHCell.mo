within FirstBookExamples.Chapter8;
model HHCell "A Hodgkin-Huxley Nerve Cell"
  extends FirstBookExamples.Icons.RunnableExample;
protected
  parameter Modelica.SIunits.Diameter d=0.5e-3;
  parameter Modelica.SIunits.Diameter L=5e-3;
  parameter Modelica.SIunits.Area area=(d/2)^2.0*Modelica.Constants.pi*L;
public
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=-1e-8,
    width=10,
    period=20e-3,
    startTime=0.5)  annotation (Placement(transformation(extent={{-100,
            -10},{-80,10}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent is
    annotation (Placement(transformation(
        origin={-50,0},
        extent={{20,-20},{-20,20}},
        rotation=90)));
  HodgkinHuxley.MembraneCapacitance C(membrane_area=area)
    annotation (Placement(transformation(
        origin={-10,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  HodgkinHuxley.SodiumChannel HH_Na(membrane_area=area)
    annotation (Placement(transformation(
        origin={20,0},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  HodgkinHuxley.PotassiumChannel HH_K(membrane_area=area)
    annotation (Placement(transformation(
        origin={50,0},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  HodgkinHuxley.LeakageChannel HH_L(membrane_area=area)
    annotation (Placement(transformation(
        origin={80,0},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground g
    annotation (Placement(transformation(extent={{10,-78},{30,-58}})));
equation
  connect(HH_Na.p, is.p) annotation (Line(points={{20,20},{20,40},{-50,
          40},{-50,20}}));
  connect(HH_K.p, is.p) annotation (Line(points={{50,20},{50,40},{-50,
          40},{-50,20}}));
  connect(HH_L.p, is.p) annotation (Line(points={{80,20},{80,40},{-50,
          40},{-50,20}}));
  connect(C.p, is.p) annotation (Line(points={{-10,10},{-10,40},{-50,40},
          {-50,20}}));
  connect(is.n, C.n)
    annotation (Line(points={{-50,-20},{-50,-40},{-10,-40},{-10,-10}}));
  connect(HH_Na.n, C.n)
    annotation (Line(points={{20,-20},{20,-40},{-10,-40},{-10,-10}}));
  connect(HH_K.n, C.n)
    annotation (Line(points={{50,-20},{50,-40},{-10,-40},{-10,-10}}));
  connect(HH_L.n, C.n)
    annotation (Line(points={{80,-20},{80,-40},{-10,-40},{-10,-10}}));
  connect(HH_Na.n, g.p) annotation (Line(points={{20,-20},{20,-40},{20,
          -58}}));

  connect(is.i, pulse.y) annotation (Line(points={{-64,8.88178e-16},{-72,
          8.88178e-16},{-72,0},{-79,0}}, color={0,0,127}));
  annotation (experiment(StopTime=0.8),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter8/HHCell.mos" "Simulate HHCell"),
    Diagram(graphics={
        Line(
          points={{-100,30},{100,30}},
          color={160,160,164},
          pattern=LinePattern.Dot),
        Line(
          points={{-100,-30},{100,-30}},
          color={160,160,164},
          pattern=LinePattern.Dot),
        Line(
          points={{-100,32},{100,32}},
          color={160,160,164},
          pattern=LinePattern.Dot),
        Line(
          points={{-100,-32},{100,-32}},
          color={160,160,164},
          pattern=LinePattern.Dot),
        Text(
          extent={{-92,60},{-56,52}},
          lineColor={160,160,164},
          textString=
               "Membrane Wall"),
        Line(
          points={{-70,52},{-70,34}},
          color={160,160,164},
          arrow={Arrow.None,Arrow.Filled})}));
end HHCell;
