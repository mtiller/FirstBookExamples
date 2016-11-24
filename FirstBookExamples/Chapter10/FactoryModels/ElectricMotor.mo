within FirstBookExamples.Chapter10.FactoryModels;
model ElectricMotor
  extends Actuator;
  Modelica.Mechanics.Rotational.Components.Inertia rotor(J=0.2)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Electrical.Analog.Basic.EMF EMF1(k=1)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=250)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Electrical.Analog.Basic.Inductor L1(L=2)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
equation
  connect(rotor.flange_b, driver) annotation (Line(points={{20,
          5.55112e-16},{100,0}}));
  connect(L1.n, EMF1.p) annotation (Line(points={{-30,40},{-26,40},{
          -20,40},{-20,10}}, color={0,0,255}));
  connect(p, R1.p) annotation (Line(points={{-100,40},{-90,40},{-80,
          40}}, color={0,0,255}));
  connect(R1.n, L1.p) annotation (Line(points={{-60,40},{-55,40},{-50,
          40}}, color={0,0,255}));
  connect(n, EMF1.n) annotation (Line(points={{-100,-40},{-60,-40},{
          -20,-40},{-20,-10}}, color={0,0,255}));
  connect(EMF1.flange, rotor.flange_a)
    annotation (Line(points={{-10,0},{0,0}}, color={0,0,0}));
  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-80,60},{80,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Rectangle(
          extent={{90,10},{80,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Line(points={{-90,40},{-80,40}}),
        Line(points={{-90,-40},{-80,-40}}),
        Polygon(
          points={{-40,-40},{-60,-80},{-80,-80},{-80,-100},{80,-100},
              {80,-80},{60,-80},{40,-40},{-40,-40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Diagram(graphics={Text(
          extent={{-70,10},{-26,-8}},
          lineColor={0,0,0},
          textString=
               "Ideal Motor")}));
end ElectricMotor;
