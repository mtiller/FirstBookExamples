within FirstBookExamples.Thermal;
package Examples
  extends Modelica.Icons.Library;
  model TwoMasses "Simple conduction test"
    discrete Modelica.SIunits.Temperature Tf "Projected final temperature";
    Basic1D.Capacitance mass1(n(T(start=400, fixed=true))) annotation (Placement(
          transformation(extent={{-100,-20},{-40,40}}, rotation=0)));
    Basic1D.Capacitance mass2 annotation (Placement(transformation(
            extent={{40,-20},{100,40}}, rotation=0)));
    Basic1D.Conduction conduction annotation (Placement(
          transformation(extent={{-30,-20},{30,40}}, rotation=0)));
  equation
    connect(mass1.n, conduction.a) annotation (Line(points={{-70,10},
            {-30,10}}));
    connect(conduction.b, mass2.n) annotation (Line(points={{30,10},{
            70,10}}, color={255,127,0}));
  algorithm
    when (initial()) then
      Tf := (mass1.n.T*mass1.V*mass1.rho*mass1.cp + mass2.n.T*mass2.V*mass2.
        rho*mass2.cp)/(mass1.V*mass1.rho*mass1.cp + mass2.V*mass2.rho*mass2.cp);
    end when;
    annotation (
      Documentation(info="This tests the thermal response of two masses connected by a conducting element.  This example
also helps verify that the Modelica sign conventions have been obeyed.

The expected solution would be for the mass with the higher temperature to cool off while the
mass with a warmer temperature heats up.  They should each asymptotically approach the
temperature that results from dividing the total initial energy in the system by the
sum of the mass of each element times that elements specific heat.  In other words:

Tf = (T1(t=0)*m1*cp1+T2(t=0)*m2*cp2)/(m1*cp1+m2*cp2)

"));
  end TwoMasses;

  model ThermalSpring "Thermal Spring Test"
    MixedDomain.RotationalSpring spring1(unstretched_nom=1) annotation (Placement(
          transformation(extent={{0,20},{-20,40}}, rotation=0)));
    MixedDomain.RotationalSpring spring2(unstretched_nom=1) annotation (Placement(
          transformation(extent={{0,-60},{-20,-40}}, rotation=0)));
    Basic1D.Capacitance mass1(n(T(start=300, fixed=true))) annotation (Placement(
          transformation(extent={{-20,50},{0,70}}, rotation=0)));
    Basic1D.Conduction Conduction1 annotation (Placement(
          transformation(extent={{20,50},{40,70}}, rotation=0)));
    Basic1D.Capacitance mass2(n(T(start=400, fixed=true))) annotation (Placement(
          transformation(extent={{60,50},{80,70}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed mount2(phi0=1)
      annotation (Placement(transformation(extent={{-60,-60},{-40,-40}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed mount3 annotation
      (Placement(transformation(extent={{20,-60},{40,-40}}, rotation=
              0)));
    Modelica.Mechanics.Rotational.Components.Fixed mount1 annotation
      (Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia
      annotation (Placement(transformation(extent={{-60,20},{-40,40}},
            rotation=0)));
    Basic1D.Capacitance mass3(n(T(start=300, fixed=true))) annotation (Placement(
          transformation(extent={{-20,-30},{0,-10}}, rotation=0)));
    Basic1D.Conduction Conduction2 annotation (Placement(
          transformation(extent={{20,-30},{40,-10}}, rotation=0)));
    Basic1D.Capacitance mass4(n(T(start=400, fixed=true))) annotation (Placement(
          transformation(extent={{60,-30},{80,-10}}, rotation=0)));
  equation
    connect(mass2.n, Conduction1.b) annotation (Line(points={{70,60},
            {40,60}}, color={255,0,0}));
    connect(Conduction1.a, mass1.n) annotation (Line(points={{20,60},
            {-10,60}}, color={255,0,0}));
    connect(mount2.flange, spring2.flange_b)
      annotation (Line(points={{-50,-50},{-20,-50}}));
    connect(spring2.flange_a, mount3.flange)
      annotation (Line(points={{5.55112e-16,-50},{30,-50}}));
    connect(inertia.flange_b, spring1.flange_b) annotation (Line(
          points={{-40,30},{-20,30}}));
    connect(spring1.flange_a, mount1.flange)
      annotation (Line(points={{5.55112e-16,30},{30,30}}));
    connect(mass4.n, Conduction2.b) annotation (Line(points={{70,-20},
            {40,-20}}, color={255,0,0}));
    connect(Conduction2.a, mass3.n) annotation (Line(points={{20,-20},
            {-10,-20}}, color={255,0,0}));
    connect(spring1.node_a, mass1.n) annotation (Line(points={{-10,36},
            {-10,60}}));
    connect(spring2.node_a, mass3.n) annotation (Line(points={{-10,
            -44},{-10,-20}}));
    annotation (
      Documentation(info="This example tests the \"ThermalSpring\" model.  The thermal spring model is a means by which
thermal energy can be translated into mechanical energy through thermal expansion.  This example
tests the effect of allow or disallowing such expansion.  In the case where the expansion is allowed,
it does work on an inertia.  When the expansion is not allowed, the energy is stored as potential
energy within the spring.
"));
  end ThermalSpring;

  model AllModes "Test all basic modes of heat transfer"
    Basic1D.BlackBodyRadiation radiation(F=0.5,A=0.1)
                                                     annotation (Placement(
          transformation(extent={{40,-10},{60,10}}, rotation=0)));
    Basic1D.Capacitance body2(V=2) annotation (Placement(
          transformation(extent={{10,-10},{30,10}}, rotation=0)));
    Basic1D.Capacitance body1(V=2) annotation (Placement(
          transformation(extent={{-50,-10},{-30,10}}, rotation=0)));
    Basic1D.Convection convection(h=30, A=1) annotation (Placement(
          transformation(extent={{-60,-10},{-80,10}}, rotation=0)));
    Basic1D.Conduction conduction(k=10) annotation (Placement(
          transformation(extent={{-20,-10},{0,10}}, rotation=0)));
    BoundaryConditions.FixedTemperature LeftBC(T=600) annotation (Placement(
          transformation(extent={{-90,-10},{-110,10}}, rotation=0)));
    BoundaryConditions.VariableTemperature TempBC annotation (Placement(
          transformation(extent={{70,-10},{90,10}}, rotation=0)));
    Modelica.Blocks.Sources.Trapezoid RightTemp(
      amplitude={800},
      rising={0.25},
      width={1},
      falling={0.25},
      period={2.5},
      offset={500},
      startTime={1}) annotation (Placement(transformation(extent={{50,
              20},{70,40}}, rotation=0)));
  equation
    connect(conduction.b, body2.n) annotation (Line(points={{
            5.55112e-16,5.55112e-16},{20,5.55112e-16}}, color={255,0,
            0}));
    connect(conduction.a, body1.n) annotation (Line(points={{-20,
            5.55112e-16},{-40,5.55112e-16}}, color={255,0,0}));
    connect(body2.n, radiation.a) annotation (Line(points={{20,
            5.55112e-16},{40,5.55112e-16}}, color={255,0,0}));
    connect(convection.a, body1.n) annotation (Line(points={{-60,
            5.55112e-16},{-40,5.55112e-16}}, color={255,0,0}));
    connect(LeftBC.n, convection.b) annotation (Line(points={{-90,
            5.55112e-16},{-80,5.55112e-16}}, color={255,0,0}));
    connect(radiation.b, TempBC.n) annotation (Line(points={{60,
            5.55112e-16},{70,5.55112e-16}}, color={255,0,0}));
    connect(RightTemp.y, TempBC.T) annotation (Line(points={{71,30},{
            100,30},{100,0},{91,5.55112e-16}}));
    annotation (
      Documentation(info="This model tests the basic modes of heat transfer (conduction, convection and radiation) along with fixed and
variable temperature bounday conditions.
"));
  end AllModes;
end Examples;
