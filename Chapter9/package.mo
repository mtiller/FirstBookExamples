package Chapter9 "Models from Chapter 9"
extends BookExamples.Icons.BookExample;


annotation (
  Coordsys(
    extent=[0, 0; 385, 218], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.26, 
    y=0.42, 
    width=0.38, 
    height=0.34, 
    library=1, 
    autolayout=1), 
  Documentation(info="The models in this package are taken from
Chapter 9 of:

'Introduction to Physical Modeling with Modelica'

by Michael Tiller
"));
end Chapter9;
