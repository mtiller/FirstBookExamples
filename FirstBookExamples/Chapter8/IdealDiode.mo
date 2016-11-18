within FirstBookExamples.Chapter8;
model IdealDiode "An Ideal Diode"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
protected
  Real s "Parametric independent variable";
  Boolean open;
equation
  open = s <= 0;
  v = if open then s else 0;
  i = if open then 0 else s;
end IdealDiode;
