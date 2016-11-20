within FirstBookExamples.Chapter4;
model CompareControllers "Comparing various controllers"
  extends FirstBookExamples.Icons.RunnableExample;
  ControllerAndMotor pic;
  ControllerAndMotor pc(redeclare PController con(Kp=1.1));
  ControllerAndMotor pdc(redeclare PDController con(Kp=1.1, Kd=0.2));
  annotation (experiment(StopTime=20),
              __Dymola_Commands(file="CompareControllers.mos" "Simulate to compare controllers"));
end CompareControllers;