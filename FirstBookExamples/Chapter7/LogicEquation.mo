block LogicEquation
  Modelica.Blocks.Interfaces.BooleanInPort i1(n=1)
    annotation (extent=[-110, 30; -90, 50]);
  Modelica.Blocks.Interfaces.BooleanInPort i2(n=1)
    annotation (extent=[90, 30; 110, 50]);
  Modelica.Blocks.Interfaces.BooleanInPort i3(n=1)
    annotation (extent=[-110, -10; -90, 10]);
  Modelica.Blocks.Interfaces.BooleanOutPort o1(n=1)
    annotation (extent=[90, -10; 110, 10]);
  Modelica.Blocks.Interfaces.BooleanOutPort o2(n=1)
    annotation (extent=[-110, -50; -90, -30]);
equation
  o1.signal = not (i1.signal and i3.signal) or i2.signal;
  o2.signal = not i1.signal and i2.signal;
end LogicEquation;
