within FirstBookExamples.Chapter3;
model RotationalPendulum
  import Modelica.SIunits;

  Modelica.Mechanics.Rotational.Interfaces.Flange_a p
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  parameter SIunits.Length L=2.0;
  parameter SIunits.Mass m=1.0;
protected
  SIunits.AngularVelocity omega;
  SIunits.AngularAcceleration alpha;
  parameter SIunits.MomentOfInertia J=m*L^2;
  constant Real g=Modelica.Constants.g_n;
equation
  omega = der(p.phi);
  alpha = der(omega);
  m*g*L*Modelica.Math.sin(p.phi) + J*alpha = p.tau;
end RotationalPendulum;
