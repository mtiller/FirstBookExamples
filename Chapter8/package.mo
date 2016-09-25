package Chapter8 "Models from Chapter 8"
extends BookExamples.Icons.BookExample;


annotation (
  Coordsys(
    extent=[0, 0; 398, 304], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.22, 
    y=0.36, 
    width=0.4, 
    height=0.46, 
    library=1, 
    autolayout=1), 
  Documentation(info="The models in this package are taken from
Chapter 8 of:

'Introduction to Physical Modeling with Modelica'

by Michael Tiller
"));
end Chapter8;
