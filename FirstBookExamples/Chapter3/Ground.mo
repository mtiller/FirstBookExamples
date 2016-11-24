within FirstBookExamples.Chapter3;
model Ground "Ground"
  ElectricalPin ground annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
equation
  ground.v = 0;
end Ground;
