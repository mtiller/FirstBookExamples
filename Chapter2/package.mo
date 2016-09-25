package Chapter2 "Models from Chapter 2"
extends BookExamples.Icons.BookExample;


annotation (
  Coordsys(
    extent=[0, 0; 422, 212], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.01, 
    y=0.01, 
    width=0.42, 
    height=0.34, 
    library=1, 
    autolayout=1), 
  Documentation(info="The models in this package are taken from
Chapter 2 of:

'Introduction to Physical Modeling with Modelica'

by Michael Tiller
"));
end Chapter2;
