within FirstBookExamples.Chapter6;
model FixedTemperature
  Modelica.Blocks.Interfaces.InPort T(final n=1)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
          rotation=0)));
  ThermalNode d annotation (Placement(transformation(extent={{90,-10},
            {110,10}}, rotation=0)));
equation
  d.T = T.signal[1];
end FixedTemperature;
