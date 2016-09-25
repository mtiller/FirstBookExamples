model EmptyingTank3 
  extends BookExamples.Icons.RunnableExample;
  annotation (experiment(StopTime=5),
              Commands(file="EmptyingTank.mos" "Simulate EmptyingTank3"));
  Real x(start=2);
equation 
  der(x) = noEvent(if x > 0 then -(x^.5) else 0.0);
end EmptyingTank3;
