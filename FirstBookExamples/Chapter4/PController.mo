within FirstBookExamples.Chapter4;
block PController "A proporational gain controller"
  extends Controller;
  parameter Real Kp=1 "Proportional gain";
protected
  Real e "reference error";
equation
  e = command.signal[1] - sensor.signal[1];
  driver.signal[1] = Kp*e;
  annotation (Diagram);
end PController;
