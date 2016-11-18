within FirstBookExamples.Chapter2;
model ComparePendulums
  extends FirstBookExamples.Icons.RunnableExample;
  SimplePendulum linear(theta(start=2.3));
  NonlinearPendulum nonlinear(theta(start=2.3));
  annotation (experiment(StopTime=10), __Dymola_Commands(file="CompareSmallTheta.mos"
        "Compare linear and nonlinear model for small amplitudes", file=
          "CompareLargeTheta.mos"
        "Compare linear and nonlinear model for large amplitudes"));
end ComparePendulums;
