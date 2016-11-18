model SimplePendulum
  extends FirstBookExamples.Icons.RunnableExample;
  annotation (experiment(StopTime=10), Commands(file="SimplePendulum.mos"
        "Simulate SimplePendulum"));
  parameter Real L=2;
  constant Real g=9.81;
  Real theta;
  Real omega;
equation
  der(theta) = omega;
  der(omega) = -(g/L)*theta;
end SimplePendulum;
