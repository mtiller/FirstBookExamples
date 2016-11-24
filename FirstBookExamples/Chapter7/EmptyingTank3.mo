within FirstBookExamples.Chapter7;
model EmptyingTank3
  extends FirstBookExamples.Icons.RunnableExample;
  Real x(start=2);
equation
  der(x) = noEvent(if x > 0 then -(x^0.5) else 0.0);
  annotation (experiment(StopTime=5),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter7/EmptyingTank.mos" "Simulate EmptyingTank3"));
end EmptyingTank3;
