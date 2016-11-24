within FirstBookExamples.Chapter4;
block PDController "An ideal PD controller"
  extends Controller;
  parameter Real Kp=1 "Proportional gain";
  parameter Real Kd=1 "Differential gain";
protected
  Real e "reference error";
equation
  e = command - sensor;
  driver = Kp*e + Kd*der(e);
end PDController;
