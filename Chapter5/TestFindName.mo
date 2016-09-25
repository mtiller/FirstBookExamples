model TestFindName 
  extends BookExamples.Icons.RunnableExample;
  parameter String names[:]={"H2O","CO2","N2"};
  parameter Integer CO2=FindName(names, "CO2");
  annotation (experiment(StopTime=1),
              Commands(file="TestFindName.mos" "Simulate TestFindName"));
end TestFindName;
