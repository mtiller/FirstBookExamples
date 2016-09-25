package Chapter5 
extends BookExamples.Icons.BookExample;


annotation (
  Coordsys(
    extent=[0, 0; 542, 219], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.12, 
    y=0.19, 
    width=0.54, 
    height=0.34, 
    library=1, 
    autolayout=1), 
  Documentation(info="The models in this package are taken from
Chapter 5 of:

'Introduction to Physical Modeling with Modelica'

by Michael Tiller
"));
end Chapter5;
