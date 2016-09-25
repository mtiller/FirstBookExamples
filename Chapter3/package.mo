package Chapter3 "Models from Chapter 3"
extends BookExamples.Icons.BookExample;


annotation (
  Coordsys(
    extent=[0, 0; 598, 401], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.05, 
    y=0.07, 
    width=0.59, 
    height=0.58, 
    library=1, 
    autolayout=1), 
  Documentation(info="The models in this package are taken from
Chapter 3 of:

'Introduction to Physical Modeling with Modelica'

by Michael Tiller
"));
end Chapter3;
