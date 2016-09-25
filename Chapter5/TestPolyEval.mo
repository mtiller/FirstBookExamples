model TestPolyEval 
  extends BookExamples.Icons.RunnableExample;
  parameter Real coefs[3]={2.0,1.0,2.0};
  Real y;
  Real fdy;
  Real y2(start = PolyEval(0, coefs));
  annotation (experiment(StopTime=10),
              Commands(file="TestPolyEval.mos" "Simulate TestPolyEval"));
equation 
  (y,fdy) = PolyEval(time, coefs);
  der(y2) = fdy;
end TestPolyEval;
