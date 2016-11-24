within FirstBookExamples.Chapter4;
partial block Controller "A generic controller interface"
  import Modelica.Blocks;

  Blocks.Interfaces.RealInput command "Command signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Blocks.Interfaces.RealInput sensor "Sensor signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Blocks.Interfaces.RealOutput driver "Driver output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
end Controller;
