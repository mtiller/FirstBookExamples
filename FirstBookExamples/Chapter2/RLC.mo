within FirstBookExamples.Chapter2;
model RLC
  extends FirstBookExamples.Icons.RunnableExample;
  parameter Modelica.SIunits.Resistance R=15;
  parameter Modelica.SIunits.Capacitance C=100e-6;
  parameter Modelica.SIunits.Inductance L=100e-3;

  Modelica.SIunits.Voltage V_a;
  Modelica.SIunits.Voltage V_b;
  Modelica.SIunits.Voltage V_c;
  Modelica.SIunits.Current i_V;
  Modelica.SIunits.Current i_R;
  Modelica.SIunits.Current i_C;
  Modelica.SIunits.Current i_L;
equation
  V_a = if time >= 1 then 1.0 else 0.0;
  L*der(i_L) = (V_a - V_b);
  R*i_R = V_b - V_c;
  i_C = C*der(V_c);
  i_V - i_L = 0;
  i_L - i_R = 0;
  i_R - i_C = 0;
  annotation (experiment(
      StopTime=2,
      Tolerance=1E-8), __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter2/RLC.mos" "Simulate RLC"));
end RLC;
