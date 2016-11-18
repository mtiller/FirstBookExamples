within FirstBookExamples.Chapter2;
model NonlinearPendulum
  Real theta;
  Real omega;
  parameter Real L=2;
  constant Real g=9.81;
equation
  der(theta) = omega;
  der(omega) = -(g/L)*Modelica.Math.sin(theta);
end NonlinearPendulum;
