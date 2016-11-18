within FirstBookExamples.Chapter4;
block PDController "An ideal PD controller"
  extends Controller;
  parameter Real Kp=1 "Proportional gain";
  parameter Real Kd=1 "Differential gain";
protected
  Real e "reference error";
equation
  e = command.signal[1] - sensor.signal[1];
  driver.signal[1] = Kp*e + Kd*der(e);
end PDController;
