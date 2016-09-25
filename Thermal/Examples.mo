package Examples 
  extends Modelica.Icons.Library;
  model TwoMasses "Simple conduction test" 
    discrete Modelica.SIunits.Temperature Tf "Projected final temperature";
    Basic1D.Capacitance mass1(n(T(start=400, fixed=true))) annotation (extent=
          [-100, -20; -40, 40]);
    Basic1D.Capacitance mass2 annotation (extent=[40, -20; 100, 40]);
    Basic1D.Conduction conduction annotation (extent=[-30, -20; 30, 40]);
  equation 
    connect(mass1.n, conduction.a) annotation (points=[-70, 10; -30, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.14, 
        y=0.16, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This tests the thermal response of two masses connected by a conducting element.  This example
also helps verify that the Modelica sign conventions have been obeyed.

The expected solution would be for the mass with the higher temperature to cool off while the
mass with a warmer temperature heats up.  They should each asymptotically approach the
temperature that results from dividing the total initial energy in the system by the
sum of the mass of each element times that elements specific heat.  In other words:

Tf = (T1(t=0)*m1*cp1+T2(t=0)*m2*cp2)/(m1*cp1+m2*cp2)

"));
    connect(conduction.b, mass2.n) annotation (points=[30, 10; 70, 10], style(
          color=45));
  algorithm 
    when (initial()) then
      Tf := (mass1.n.T*mass1.V*mass1.rho*mass1.cp + mass2.n.T*mass2.V*mass2.
        rho*mass2.cp)/(mass1.V*mass1.rho*mass1.cp + mass2.V*mass2.rho*mass2.cp)
        ;
    end when;
  end TwoMasses;
  model ThermalSpring "Thermal Spring Test" 
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.1, 
        y=0.17, 
        width=0.6, 
        height=0.6), 
      Documentation(info="This example tests the \"ThermalSpring\" model.  The thermal spring model is a means by which
thermal energy can be translated into mechanical energy through thermal expansion.  This example
tests the effect of allow or disallowing such expansion.  In the case where the expansion is allowed,
it does work on an inertia.  When the expansion is not allowed, the energy is stored as potential
energy within the spring.
"));
    MixedDomain.RotationalSpring spring1(unstretched_nom=1) annotation (extent
        =[0, 20; -20, 40]);
    MixedDomain.RotationalSpring spring2(unstretched_nom=1) annotation (extent
        =[0, -60; -20, -40]);
    Basic1D.Capacitance mass1(n(T(start=300, fixed=true))) annotation (extent=
          [-20, 50; 0, 70]);
    Basic1D.Conduction Conduction1 annotation (extent=[20, 50; 40, 70]);
    Basic1D.Capacitance mass2(n(T(start=400, fixed=true))) annotation (extent=
          [60, 50; 80, 70]);
    Modelica.Mechanics.Rotational.Fixed mount2(phi0=1) annotation (extent=[-60
          , -60; -40, -40]);
    Modelica.Mechanics.Rotational.Fixed mount3 annotation (extent=[20, -60; 40
          , -40]);
    Modelica.Mechanics.Rotational.Fixed mount1 annotation (extent=[20, 20; 40
          , 40]);
    Modelica.Mechanics.Rotational.Inertia inertia annotation (extent=[-60, 20
          ; -40, 40]);
    Basic1D.Capacitance mass3(n(T(start=300, fixed=true))) annotation (extent=
          [-20, -30; 0, -10]);
    Basic1D.Conduction Conduction2 annotation (extent=[20, -30; 40, -10]);
    Basic1D.Capacitance mass4(n(T(start=400, fixed=true))) annotation (extent=
          [60, -30; 80, -10]);
  equation 
    connect(mass2.n, Conduction1.b) annotation (points=[70, 60; 40, 60], 
        style(color=41));
    connect(Conduction1.a, mass1.n) annotation (points=[20, 60; -10, 60], 
        style(color=41));
    connect(mount2.flange_b, spring2.flange_b) annotation (points=[-50, -50; -
          20, -50]);
    connect(spring2.flange_a, mount3.flange_b) annotation (points=[5.55112e-16
          , -50; 30, -50]);
    connect(inertia.flange_b, spring1.flange_b) annotation (points=[-40, 30; -
          20, 30]);
    connect(spring1.flange_a, mount1.flange_b) annotation (points=[5.55112e-16
          , 30; 30, 30]);
    connect(mass4.n, Conduction2.b) annotation (points=[70, -20; 40, -20], 
        style(color=41));
    connect(Conduction2.a, mass3.n) annotation (points=[20, -20; -10, -20], 
        style(color=41));
    connect(spring1.node_a, mass1.n) annotation (points=[-10, 36; -10, 60]);
    connect(spring2.node_a, mass3.n) annotation (points=[-10, -44; -10, -20]);
  end ThermalSpring;
  annotation (Coordsys(
      extent=[0, 0; 944, 657], 
      grid=[1, 1], 
      component=[20, 20]), Window(
      x=0.39, 
      y=0.39, 
      width=0.6, 
      height=0.6, 
      library=1, 
      autolayout=1));
  model AllModes "Test all basic modes of heat transfer" 
    annotation (
      Coordsys(
        extent=[-150, -50; 150, 50], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.09, 
        y=0.27, 
        width=0.66, 
        height=0.67), 
      Documentation(info="This model tests the basic modes of heat transfer (conduction, convection and radiation) along with fixed and
variable temperature bounday conditions.
"));
    Basic1D.BlackBodyRadiation radiation(F=.5, A=.1) annotation (extent=[40, -
          10; 60, 10]);
    Basic1D.Capacitance body2(V=2) annotation (extent=[10, -10; 30, 10]);
    Basic1D.Capacitance body1(V=2) annotation (extent=[-50, -10; -30, 10]);
    Basic1D.Convection convection(h=30, A=1) annotation (extent=[-60, -10; -80
          , 10]);
    Basic1D.Conduction conduction(k=10) annotation (extent=[-20, -10; 0, 10]);
    BoundaryConditions.FixedTemperature LeftBC(T=600) annotation (extent=[-90
          , -10; -110, 10]);
    BoundaryConditions.VariableTemperature TempBC annotation (extent=[70, -10
          ; 90, 10]);
    Modelica.Blocks.Sources.Trapezoid RightTemp(
      amplitude={800}, 
      rising={.25}, 
      width={1}, 
      falling={.25}, 
      period={2.5}, 
      offset={500}, 
      startTime={1}) annotation (extent=[50, 20; 70, 40]);
  equation 
    connect(conduction.b, body2.n) annotation (points=[5.55112e-16, 
          5.55112e-16; 20, 5.55112e-16], style(color=41));
    connect(conduction.a, body1.n) annotation (points=[-20, 5.55112e-16; -40, 
          5.55112e-16], style(color=41));
    connect(body2.n, radiation.a) annotation (points=[20, 5.55112e-16; 40, 
          5.55112e-16], style(color=41));
    connect(convection.a, body1.n) annotation (points=[-60, 5.55112e-16; -40, 
          5.55112e-16], style(color=41));
    connect(LeftBC.n, convection.b) annotation (points=[-90, 5.55112e-16; -80
          , 5.55112e-16], style(color=41));
    connect(radiation.b, TempBC.n) annotation (points=[60, 5.55112e-16; 70, 
          5.55112e-16], style(color=41));
    connect(RightTemp.outPort, TempBC.T) annotation (points=[71, 30; 100, 30; 
          100, 0; 91, 5.55112e-16]);
  end AllModes;
end Examples;
