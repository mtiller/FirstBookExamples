within FirstBookExamples.Chapter6;
model GravitationalAttraction
  BodyAttachment b1 annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
  BodyAttachment b2 annotation (Placement(transformation(extent={{90,
            -10},{110,10}})));
equation
  b1.f = -CalcForce(b1.x, b1.m, b2.x, b2.m);
  b2.f = -b1.f;
end GravitationalAttraction;
