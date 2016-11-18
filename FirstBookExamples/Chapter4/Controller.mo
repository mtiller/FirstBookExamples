within FirstBookExamples.Chapter4;
partial block Controller "A generic controller interface"
  import Modelica.Blocks;

  Blocks.Interfaces.InPort command "Command signal"
    annotation (Placement(transformation(extent={{-110,10},{-90,30}},
          rotation=0)));
  Blocks.Interfaces.InPort sensor "Sensor signal"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}},
          rotation=0)));
  Blocks.Interfaces.OutPort driver "Driver output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}},
          rotation=0)));
  annotation (Diagram(graphics));
end Controller;
