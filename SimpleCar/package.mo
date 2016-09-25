package SimpleCar "A library to demonstrate models used in analyzing vehicle performance"
annotation (
  Dymola(checkSum="2716777356:2597862928"),
  Coordsys(
    extent=[0, 0; 442, 384], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.45, 
    y=0.01, 
    width=0.35, 
    height=0.49, 
    library=1, 
    autolayout=1), 
  Documentation(info="The \"SimpleCar\" package and all models contained in it
are copyrighted by Michael Tiller, 2001.  These models
may be copied, modified and/or resdistributed provided
that the copyright notice remains.

No warranty is provided for these models.
"));
end SimpleCar;
