within FirstBookExamples.Chapter5;
model TestPolyEval
  extends FirstBookExamples.Icons.RunnableExample;
  parameter Real coefs[3]={2.0,1.0,2.0};
  Real y;
  Real fdy;
  Real y2(start = PolyEval(0, coefs));
equation
  (y,fdy) = PolyEval(time, coefs);
  der(y2) = fdy;
  annotation (experiment(StopTime=10),
              Commands(file="TestPolyEval.mos" "Simulate TestPolyEval"));
end TestPolyEval;
