within FirstBookExamples.Chapter8;
model BacklashCOR
  import Modelica.Mechanics.Rotational;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliant;
  parameter Modelica.SIunits.Angle b=0.05;
  parameter Modelica.SIunits.Inertia I1=1;
  parameter Modelica.SIunits.Inertia I2=1;
  parameter Real K=1 "Coefficient of Restitution";
protected
  Modelica.SIunits.AngularVelocity w1;
  Modelica.SIunits.AngularVelocity w2;
  Modelica.SIunits.AngularAcceleration a1;
  Modelica.SIunits.AngularAcceleration a2;
equation
  w1 = der(flange_a.phi);
  w2 = der(flange_b.phi);
  a1 = der(w1);
  a2 = der(w2);
  tau = 0;
  when phi_rel >= b/2 or phi_rel <= -b/2 then
    reinit(w1, ((I1 - K*I2)*pre(w1) + I2*(1 + K)*pre(w2))/(I1 + I2));
    reinit(w2, ((I2 - K*I1)*pre(w2) + I1*(1 + K)*pre(w1))/(I1 + I2));
  end when;
end BacklashCOR;
