within FirstBookExamples.Chapter5;
model TestFindName
  extends FirstBookExamples.Icons.RunnableExample;
  parameter String names[:]={"H2O","CO2","N2"};
  parameter Integer CO2=FindName(names, "CO2");
  annotation (experiment(StopTime=1),
              __Dymola_Commands(file="modelica://FirstBookExamples/Resources/Scripts/Dymola/Chapter5/TestFindName.mos" "Simulate TestFindName"));
end TestFindName;
