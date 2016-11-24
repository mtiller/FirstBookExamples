within FirstBookExamples.Chapter8;
model SpringBacklash
  import Modelica.Mechanics.Rotational;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliant;
  parameter Modelica.SIunits.Angle b=0.05 "Backlash amount";
  parameter Real c=1e+5 "Spring stiffness";
  parameter Real d=0 "Damping coefficient";
protected
  Modelica.SIunits.AngularVelocity w_rel;
equation
  w_rel = der(phi_rel);
  if phi_rel <= -b/2 then
    tau = c*(phi_rel + b/2) + d*w_rel;
  elseif phi_rel >= b/2 then
    tau = c*(phi_rel - b/2) + d*w_rel;
  else
    tau = 0;
  end if;
end SpringBacklash;
