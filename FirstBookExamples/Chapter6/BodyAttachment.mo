within FirstBookExamples.Chapter6;
connector BodyAttachment
  import Modelica.SIunits;

  SIunits.Position x[3];
  flow SIunits.Force f[3];
  SIunits.Mass m;
end BodyAttachment;
