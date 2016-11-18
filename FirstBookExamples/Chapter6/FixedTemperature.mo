within FirstBookExamples.Chapter6;
model FixedTemperature
  Modelica.Blocks.Interfaces.InPort T(final n=1)
    annotation (extent=[-110, -10; -90, 10]);
  ThermalNode d annotation (extent=[90, -10; 110, 10]);
equation
  d.T = T.signal[1];
end FixedTemperature;
