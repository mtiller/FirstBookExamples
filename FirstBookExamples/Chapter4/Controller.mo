within FirstBookExamples.Chapter4;
partial block Controller "A generic controller interface"
  import Modelica.Blocks;

  Blocks.Interfaces.InPort command "Command signal"
    annotation (extent=[-110, 10; -90, 30]);
  Blocks.Interfaces.InPort sensor "Sensor signal"
    annotation (extent=[-110, -50; -90, -30]);
  Blocks.Interfaces.OutPort driver "Driver output signal"
    annotation (extent=[100, -10; 120, 10]);
  annotation (Diagram);
end Controller;
