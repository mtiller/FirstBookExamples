within FirstBookExamples.Chapter10.HeatingSystem;
model DigitalCircuit
  parameter Modelica.SIunits.Temperature T_on;
  parameter Modelica.SIunits.Temperature T_off;
  parameter Real tc_C[:] "C vector that characterizes the thermocouple";
  function polyval
    extends Modelica.Icons.Function;
    input Real c[:];
    input Real u;
    output Real y;
  protected
    Integer n;
  algorithm
    n := size(c, 1);
    y := 0;
    for i in 1:n loop
      y := y + c[i]*u^(n - i);
    end for;
  end polyval;
protected
  parameter Modelica.SIunits.Voltage V_on=polyval(tc_C, T_on);
  parameter Modelica.SIunits.Voltage V_off=polyval(tc_C, T_off);
  Boolean furnace_on;

public
  Modelica.Electrical.Analog.Interfaces.PositivePin thermo_n
    annotation ( Placement(
        transformation(extent={{-70,50},{-50,70}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin furnace_p
    annotation ( Placement(
        transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin furnace_n
    annotation ( Placement(
        transformation(extent={{-70,-70},{-50,-50}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin thermo_p
    annotation (Placement(
        transformation(extent={{50,50},{70,70}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin unused
    annotation ( Placement(
        transformation(extent={{50,-10},{70,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin ground
    annotation ( Placement(
        transformation(extent={{50,-70},{70,-50}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch
                                               furnace_switch
    annotation (Placement(transformation(
        origin={-30,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(thermo_n, ground)
    annotation (Line(points={{-60,60},{0,60},{0,-60},{60,-60}}));
  connect(unused, ground) annotation (Line(points={{60,0},{0,0},{0,
          -60},{60,-60}}));
  connect(furnace_switch.p, furnace_p)
    annotation (Line(points={{-30,-20},{-30,0},{-60,0}}));
  connect(furnace_switch.n, furnace_n)
    annotation (Line(points={{-30,-40},{-30,-60},{-60,-60}}));
  thermo_p.i = 0;
  furnace_switch.control = not furnace_on;

  // Control circuit logic
algorithm
  when (initial()) then
    furnace_on := thermo_p.v < V_on;
  end when;

  when (thermo_p.v >= V_off) then
    furnace_on := false;
  end when;

  when (thermo_p.v <= V_on) then
    furnace_on := true;
  end when;
  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-50,80},{50,-80}},
          lineColor={0,0,0},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Text(extent={{-66,86},{-54,74}}, textString=
                                             "Tn"),
        Text(extent={{-66,26},{-54,14}}, textString=
                                             "Fp"),
        Text(extent={{-66,-34},{-54,-46}}, textString=
                                               "Fn"),
        Text(extent={{54,86},{66,74}}, textString=
                                           "Tp"),
        Text(extent={{54,-34},{66,-46}}, textString=
                                             "g"),
        Ellipse(
          extent={{-10,80},{10,60}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,80},{10,72}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end DigitalCircuit;
