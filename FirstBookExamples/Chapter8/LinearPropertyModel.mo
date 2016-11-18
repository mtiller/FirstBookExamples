within FirstBookExamples.Chapter8;
model LinearPropertyModel
  extends ThermalPropertyModel(u(start=300*900), T(start=300));
equation
  u = 900*T;
end LinearPropertyModel;
