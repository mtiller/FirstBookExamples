within FirstBookExamples.Chapter9;
model Particle
  parameter Modelica.SIunits.Position x_init[3];
  parameter Modelica.SIunits.Velocity v_init[3];
protected
  outer function gravity
    extends GravityField;
  end gravity;
  Modelica.SIunits.Position x[3](start=x_init);
  Modelica.SIunits.Velocity v[3](start=v_init);
  Modelica.SIunits.Acceleration a[3];
  Sphere p(
    x=x[1],
    y=x[2],
    z=x[3],
    R=0.01);
equation
  // Dymola specific
  v = der(x);
  a = der(v);
  a = gravity(x);
end Particle;
