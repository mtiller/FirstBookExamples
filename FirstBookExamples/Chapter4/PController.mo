within FirstBookExamples.Chapter4;
block PController "A proporational gain controller"
  extends Controller;
  parameter Real Kp=1 "Proportional gain";
protected
  Real e "reference error";
equation
  e = command - sensor;
  driver = Kp*e;
end PController;
