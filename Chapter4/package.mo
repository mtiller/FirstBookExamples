package Chapter4 "Models from Chapter 4"
extends BookExamples.Icons.BookExample;


annotation (
  Coordsys(
    extent=[0, 0; 549, 214], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.08, 
    y=0.13, 
    width=0.54, 
    height=0.34, 
    library=1, 
    autolayout=1), 
  Documentation(info="The models in this package are taken from
Chapter 4 of:

'Introduction to Physical Modeling with Modelica'

by Michael Tiller
"));
end Chapter4;
