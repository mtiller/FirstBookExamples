within FirstBookExamples.Chapter8;
model SimplePropertyModel
  parameter Modelica.SIunits.Temperature Tl=1000;
  parameter Modelica.SIunits.Temperature Tu=1100;
  parameter Modelica.SIunits.SpecificHeatCapacity cp_s=900;
  parameter Modelica.SIunits.SpecificHeatCapacity cp_m=9000;
  parameter Modelica.SIunits.SpecificHeatCapacity cp_l=900;
  extends ThermalPropertyModel(u(start=cp_s*300));
equation
  assert(T >= 200 and T <= 2000, "T out of range");
  if T <= Tl then
    u = cp_s*T;
  elseif T <= Tu then
    u = cp_m*(T - Tl) + Tl*cp_s;
  else
    u = cp_l*(T - Tu) + cp_m*(Tu - Tl) + Tl*cp_s;
  end if;
end SimplePropertyModel;
