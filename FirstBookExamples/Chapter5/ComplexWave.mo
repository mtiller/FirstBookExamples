within FirstBookExamples.Chapter5;
function ComplexWave
  extends Modelica.Icons.Function;
  encapsulated record Data
    import Modelica;
    constant Integer num "Number of waves";
    Real a[num] "Wave amplitudes";
    Modelica.SIunits.Frequency f[num] "Wave frequencies";
    Modelica.SIunits.Angle phase[num] "Wave phase offset";
  end Data;

  input Real x "Independent variable";
  input Data d "Wave data";
  output Real y "Sum of sine waves";
protected
  Integer n;
  Real s;
algorithm
  n := d.num;
  y := 0;
  for i in 1:n loop
    s := Modelica.Math.sin(2*Modelica.Constants.pi*d.f[i]*x + d.phase[i]);
    y := y + d.a[i]*s;
  end for;
end ComplexWave;
