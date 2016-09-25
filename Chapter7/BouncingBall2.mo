model BouncingBall2 
  extends BookExamples.Icons.RunnableExample;
  import Modelica.SIunits;
  
  parameter SIunits.Mass m=1.0 "Mass of the ball";
  parameter Real c_r=.725 "Coef. of restitution";
  parameter SIunits.Radius r=0.02 "Radius of the ball";
  
  SIunits.Height h(start=5.0) "Height of the ball center";
  SIunits.Velocity v "Velocity of the ball";
  SIunits.Acceleration a "Acceleration of the ball";
  annotation (experiment(StopTime=5),
              Commands(file="BouncingBall2.mos" "Simulate BouncingBall2"));
equation 
  v = der(h);
  a = der(v);
  m*a = -m*Modelica.Constants.g_n;
  when h <= r then
    reinit(v, -c_r*pre(v));
  end when;
end BouncingBall2;
