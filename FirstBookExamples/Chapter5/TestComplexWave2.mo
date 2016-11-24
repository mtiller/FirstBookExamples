within FirstBookExamples.Chapter5;
model TestComplexWave2
  extends FirstBookExamples.Icons.RunnableExample;
  ComplexWave.Data wdata(num=3);
  Real signal;
  constant Real pi=Modelica.Constants.pi;
  Real A;
  Real B;
equation
  wdata.a = {1.3,2.2,5.8*Modelica.Math.exp(-0.54
                                               *time)};
  wdata.f = {2.0,3.0,7.0};
  wdata.phase = {0,Modelica.Constants.pi,0};
  signal = ComplexWave(time, wdata);
  A = 1.3*Modelica.Math.sin(2.0*pi*2.0*time) + 2.2*Modelica.Math.sin(2.0*pi*3.0
    *time + pi) + 5.8*Modelica.Math.sin(2.0*pi*7.0*time);
  B = 1.3*Modelica.Math.sin(2.0*pi*2.0*time) + 2.2*Modelica.Math.sin(2.0*pi*3.0
    *time + pi);
  annotation (experiment(StopTime=3),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter5/TestComplexWave2.mos" "Simulate TestComplexWave2"));
end TestComplexWave2;
