package Chapter10 "Models from Chapter 10"
extends BookExamples.Icons.BookExample;


annotation (
  Coordsys(
    extent=[0, 0; 214, 125], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.3, 
    y=0.48, 
    width=0.22, 
    height=0.22, 
    library=1, 
    autolayout=1), 
  Documentation(info="The models in this package are taken from
Chapter 10 of:

'Introduction to Physical Modeling with Modelica'

by Michael Tiller
"));
end Chapter10;
