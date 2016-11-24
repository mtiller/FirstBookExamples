within FirstBookExamples.Chapter3;
model RLC2
  extends FirstBookExamples.Icons.RunnableExample;
  import Modelica.SIunits;

  parameter SIunits.Resistance R1=15;
  parameter SIunits.Resistance R2=5000;
  parameter SIunits.Capacitance C=100e-6;
  parameter SIunits.Inductance L=100e-3;

  SIunits.Voltage V_a;
  SIunits.Voltage V_b;
  SIunits.Voltage V_c;
  SIunits.Current i_V;
  SIunits.Current i_R1;
  SIunits.Current i_R2;
  SIunits.Current i_C;
  SIunits.Current i_L;
equation
  V_a = if time >= 1 then 1.0 else 0.0;
  L*der(i_L) = V_a - V_b;
  R1*i_R1 = V_b - V_c;
  i_C = C*der(V_c);
  R2*i_R2 = V_b;
  i_V - i_L = 0;
  i_L - i_R1 - i_R2 = 0;
  i_R1 - i_C = 0;
  annotation (experiment(StopTime=2),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter3/RLC2.mos" "Simulate RLC2"));
end RLC2;
