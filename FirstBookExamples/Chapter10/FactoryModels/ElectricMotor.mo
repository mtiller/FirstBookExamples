within FirstBookExamples.Chapter10.FactoryModels;
model ElectricMotor
  extends Actuator;
  Modelica.Mechanics.Rotational.Components.Inertia rotor(J=0.2)
    annotation (Placement(transformation(extent={{0,-10},{20,10}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.EMF EMF1
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=250)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor L1(L=2)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}},
          rotation=0)));
equation
  connect(EMF1.flange, rotor.flange_a) annotation (Line(points={{-10,
          5.55112e-16},{-5.55112e-16,5.55112e-16}}));
  connect(L1.n, EMF1.p) annotation (Line(points={{-30,40},{-20,40},{
          -20,10}}));
  connect(R1.n, L1.p) annotation (Line(points={{-60,40},{-50,40}}));
  connect(R1.p, p) annotation (Line(points={{-80,40},{-100,40}}));
  connect(EMF1.n, n) annotation (Line(points={{-20,-10},{-20,-40},{
          -100,-40}}));
  connect(rotor.flange_b, driver) annotation (Line(points={{20,
          5.55112e-16},{100,0}}));
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
