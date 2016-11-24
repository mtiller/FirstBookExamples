within FirstBookExamples.Chapter2;
model FixedDelay
  extends FirstBookExamples.Icons.RunnableExample;
  parameter Modelica.SIunits.Time dt=1;
  Real x(start=1);
  Real y(start=1);
  Real z;
equation
  der(x) = -z;
  y = -der(y)/10.0 - 0.8*z;
  z = delay(x + y, dt);
  annotation (experiment(StopTime=7.5),
   __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter2/FixedDelay.mos"
        "Simulate FixedDelay"));
end FixedDelay;
