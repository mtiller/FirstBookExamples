within FirstBookExamples.Chapter3;
model ControlSystem1 "A PI Controller with Plant Model"
  extends FirstBookExamples.Icons.RunnableExample;
  import Modelica.SIunits;

  parameter Real Kp=0.4;
  parameter Real Ti=1.0;
  parameter SIunits.AngularVelocity w0=1.0;
  parameter SIunits.AngularVelocity A=0.2;
  parameter SIunits.Frequency F=0.3;
  parameter SIunits.MomentOfInertia J=0.8;
  parameter SIunits.RotationalDampingConstant d=0.1;

  SIunits.AngularVelocity w_c;
  SIunits.AngularVelocity w_m;
  SIunits.AngularVelocity delta_w;
  SIunits.Torque tau;
  SIunits.Torque i;
  SIunits.Torque p;
equation
  w_c = A*sin(2.0*Modelica.Constants.pi*F*time) + w0;
  delta_w = w_c - w_m;
  der(i) = Kp*delta_w/Ti;
  p = Kp*delta_w;
  tau = i + p;
  J*der(w_m) + d*w_m = tau;
  annotation (experiment(StopTime=20),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter3/ControlSystem1.mos" "Simulate ControlSystem1"));
end ControlSystem1;
