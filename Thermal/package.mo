package Thermal 
extends Modelica.Icons.Library2;

annotation (
  Dymola(checkSum="303660825:447394242"),
  Icon(
    Polygon(points=[-54, -6; -61, -7; -75, -15; -79, -24; -80, -34; -78, -42; 
          -73, -49; -64, -51; -57, -51; -47, -50; -41, -43; -38, -35; -40, -27
          ; -40, -20; -42, -13; -47, -7; -54, -5; -54, -6], style(color=10, 
          fillColor=8)), 
    Polygon(points=[-75, -15; -79, -25; -80, -34; -78, -42; -72, -49; -64, -51
          ; -57, -51; -47, -50; -57, -47; -65, -45; -71, -40; -74, -33; -76, 
          -23; -75, -15; -75, -15], style(color=0, fillColor=9)), 
    Polygon(points=[39, -6; 32, -7; 18, -15; 14, -24; 13, -34; 15, -42; 20, 
          -49; 29, -51; 36, -51; 46, -50; 52, -43; 55, -35; 53, -27; 53, -20; 
          51, -13; 46, -7; 39, -5; 39, -6], style(color=9, fillColor=8)), 
    Polygon(points=[18, -15; 14, -25; 13, -34; 15, -42; 21, -49; 29, -51; 36, 
          -51; 46, -50; 36, -47; 28, -45; 22, -40; 19, -33; 17, -23; 18, -15; 
          18, -15], style(color=0, fillColor=9)), 
    Line(points=[-34, -15; 9, -15], style(arrow=1)), 
    Line(points=[8, -40; -33, -40], style(arrow=1))), 
  Coordsys(
    extent=[0, 0; 442, 384], 
    grid=[1, 1], 
    component=[20, 20]), 
  Window(
    x=0.45, 
    y=0.01, 
    width=0.35, 
    height=0.49, 
    library=1, 
    autolayout=1), 
  Documentation(info="The \"Thermal\" package and all models contained in it
are copyrighted by Michael Tiller, 2001.  These models
may be copied, modified and/or resdistributed provided
that the copyright notice remains.

No warranty is provided for these models.
"));
end Thermal;
