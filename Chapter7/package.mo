package Chapter7 "Models from Chapter 7"
extends BookExamples.Icons.BookExample;


annotation (
  Coordsys(
    extent=[0, 0; 500, 402], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.19, 
    y=0.3, 
    width=0.5, 
    height=0.58, 
    library=1, 
    autolayout=1), 
  Documentation(info="The models in this package are taken from
Chapter 7 of:

'Introduction to Physical Modeling with Modelica'

by Michael Tiller
"));
end Chapter7;
