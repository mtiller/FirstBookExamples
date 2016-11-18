model CompareControllers "Comparing various controllers"
  extends FirstBookExamples.Icons.RunnableExample;
  ControllerAndMotor pic;
  ControllerAndMotor pc(redeclare PController con(Kp=1.1));
  ControllerAndMotor pdc(redeclare PDController con(Kp=1.1, Kd=.2));
  annotation (experiment(StopTime=20),
              Commands(file="CompareControllers.mos" "Simulate to compare controllers"));
end CompareControllers;
