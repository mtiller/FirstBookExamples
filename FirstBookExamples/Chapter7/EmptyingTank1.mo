within FirstBookExamples.Chapter7;
model EmptyingTank1
  Real x;
equation
  der(x) = if x > 0 then -(x^0.5) else 0.0;
end EmptyingTank1;
