model FrictionlessJoint 
  Modelica.Mechanics.Rotational.Interfaces.Flange_a a
    annotation (extent=[-110, -10; -90, 10]);
  Modelica.Mechanics.Rotational.Interfaces.Flange_b b
    annotation (extent=[90, -10; 110, 10]);
equation 
  a.tau = 0;
  b.tau = 0;
end FrictionlessJoint;
