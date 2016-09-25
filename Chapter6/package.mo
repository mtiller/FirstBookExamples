package Chapter6 "Models from Chapter 6"
extends BookExamples.Icons.BookExample;


annotation (
  Coordsys(
    extent=[0, 0; 497, 405], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.15, 
    y=0.25, 
    width=0.49, 
    height=0.59, 
    library=1, 
    autolayout=1), 
  Documentation(info="The models in this package are taken from
Chapter 6 of:

'Introduction to Physical Modeling with Modelica'

by Michael Tiller
"));
end Chapter6;
