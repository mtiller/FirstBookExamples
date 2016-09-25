block SinusoidalSignal 
  output Signal out_sig annotation (extent=[-110, -10; -90, 10]);
  
  parameter Real A=1.0 "Amplitude";
  parameter Real offset=1.0 "Offset";
  parameter Modelica.SIunits.Frequency F=1.0 "Frequency";
equation 
  out_sig.val = offset + A*sin(2.0*Modelica.Constants.pi*F*time);
end SinusoidalSignal;
