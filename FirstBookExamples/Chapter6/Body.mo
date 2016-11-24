within FirstBookExamples.Chapter6;
model Body
  import Modelica.SIunits;
  parameter SIunits.Mass M=1.0;
  parameter SIunits.Velocity init_v[3]={0,0,0};
  parameter SIunits.Position init_x[3]={0,0,0};

  BodyAttachment b annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
protected
  SIunits.Position x[3](start=init_x, fixed=true);
  SIunits.Velocity v[3](start=init_v, fixed=true);
  SIunits.Acceleration a[3];
equation
  b.x = x;
  b.m = M;
  v = der(x);
  a = der(v);
  M*a = b.f;
end Body;
