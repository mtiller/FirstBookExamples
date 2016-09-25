model FixedDelay 
  extends BookExamples.Icons.RunnableExample;
  parameter Modelica.SIunits.Time dt=1;
  Real x(start=1);
  Real y(start=1);
  Real z;
  annotation (experiment(StopTime=7.5), Commands(file="FixedDelay.mos" 
        "Simulate FixedDelay"));
equation 
  der(x) = -z;
  y = -der(y)/10.0 - 0.8*z;
  z = delay(x + y, dt);
end FixedDelay;
