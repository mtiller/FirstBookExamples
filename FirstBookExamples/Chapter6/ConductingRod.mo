within FirstBookExamples.Chapter6;
model ConductingRod
  import Modelica.SIunits;

  parameter SIunits.Length L=1.0 "Total length";
  parameter SIunits.Area A=1.0 "Cross-sectional area";
  parameter SIunits.SpecificHeatCapacity cp=1.0;
  parameter SIunits.Density rho=1.0;
  parameter SIunits.ThermalConductivity k=1.0;
  parameter Integer n=10 "Number of sections";

  ThermalNode a annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
  ThermalNode b annotation (Placement(transformation(extent={{90,-10},
            {110,10}})));
  // External connections

  parameter SIunits.Length dx=L/n;

  ThermalCapacitance cap[n](
    each L=dx,
    each A=A,
    each rho=rho,
    each cp=cp) annotation (Placement(transformation(extent={{-60,0},
            {-40,20}})));
  ThermalConduction c_cond[n - 1](
    each L=dx,
    each A=A,
    each k=k) annotation (Placement(transformation(extent={{20,0},{40,
            20}})));
  ThermalConduction l_cond(
    L=dx/2,
    A=A,
    k=k) annotation (Placement(transformation(extent={{-60,-60},{-40,
            -40}})));
  ThermalConduction r_cond(
    L=dx/2,
    A=A,
    k=k) annotation (Placement(transformation(extent={{20,-60},{40,
            -40}})));
equation
  for i in 1:n - 1 loop
    connect(c_cond[i].a, cap[i].p);
    connect(c_cond[i].b, cap[i + 1].p);
  end for;
  connect(a, l_cond.a) annotation (Line(points={{-100,0},{-60,-50}}));
  connect(l_cond.b, cap[1].p);
  connect(b, r_cond.b) annotation (Line(points={{100,0},{40,-50}}));
  connect(r_cond.a, cap[n].p);
end ConductingRod;
