within FirstBookExamples.Chapter6;
model FunctionVectorizing
  Real x1[3];
  Real x2[3];
  Real x3[3];
equation
  x1 = sqrt({1,2,3});
  x2 = mod({10,20,30}, {4,5,6});
  x3 = mod({10,20,30}, 4);
end FunctionVectorizing;
