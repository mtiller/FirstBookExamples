within FirstBookExamples.Chapter10.HeatingSystem;
model DigitalCircuit
  parameter Modelica.SIunits.Temperature T_on;
  parameter Modelica.SIunits.Temperature T_off;
  parameter Real tc_C[:] "C vector that characterizes the thermocouple";
  function polyval
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
    annotation (extent=[-70, 50; -50, 70], layer="icon");
  Modelica.Electrical.Analog.Interfaces.PositivePin furnace_p
    annotation (extent=[-70, -10; -50, 10], layer="icon");
  Modelica.Electrical.Analog.Interfaces.PositivePin furnace_n
    annotation (extent=[-70, -70; -50, -50], layer="icon");
  Modelica.Electrical.Analog.Interfaces.PositivePin thermo_p
    annotation (extent=[50, 50; 70, 70], layer="icon");
  Modelica.Electrical.Analog.Interfaces.PositivePin unused
    annotation (extent=[50, -10; 70, 10], layer="icon");
  Modelica.Electrical.Analog.Interfaces.PositivePin ground
    annotation (extent=[50, -70; 70, -50], layer="icon");
  Modelica.Electrical.Analog.Ideal.IdealSwitch furnace_switch
    annotation (extent=[-40, -40; -20, -20], rotation=270);
equation
  connect(thermo_n, ground)
    annotation (points=[-60, 60; 0, 60; 0, -60; 60, -60]);
  connect(unused, ground) annotation (points=[60, 0; 0, 0; 0, -60; 60, -60]);
  connect(furnace_switch.p, furnace_p)
    annotation (points=[-30, -20; -30, 0; -60, 0]);
  connect(furnace_switch.n, furnace_n)
    annotation (points=[-30, -40; -30, -60; -60, -60]);
  thermo_p.i = 0;
  furnace_switch.control.signal[1] = not furnace_on;

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
    Icon(
      Rectangle(extent=[-50, 80; 50, -80], style(color=0, fillColor=9)),
      Text(extent=[-66, 86; -54, 74], string="Tn"),
      Text(extent=[-66, 26; -54, 14], string="Fp"),
      Text(extent=[-66, -34; -54, -46], string="Fn"),
      Text(extent=[54, 86; 66, 74], string="Tp"),
      Text(extent=[54, -34; 66, -46], string="g"),
      Ellipse(extent=[-10, 80; 10, 60], style(color=0, fillColor=0)),
      Rectangle(extent=[-10, 80; 10, 72], style(color=0, fillColor=0))));
end DigitalCircuit;
