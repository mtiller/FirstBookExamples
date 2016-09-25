package Icons 
  annotation (
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
    Diagram, 
    Icon(Rectangle(extent=[-100, 100; 100, -100], style(color=0, fillColor=8)), 
         Text(extent=[-100, 40; 100, -40], string="Icons")));
  class BookExample 
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Icon(
        Ellipse(extent=[-100, 100; -60, 80], style(
            color=0, 
            thickness=2, 
            gradient=3, 
            fillColor=9)), 
        Rectangle(extent=[-100, 88; -62, -90], style(
            color=8, 
            gradient=1, 
            fillColor=9)), 
        Ellipse(extent=[-100, -80; -60, -100], style(
            color=0, 
            thickness=2, 
            fillColor=7)), 
        Rectangle(extent=[-80, -80; 60, -100], style(color=7, fillColor=7)), 
        Line(points=[-100, 90; -100, -88], style(color=0, thickness=2)), 
        Line(points=[-96, -84; 56, -84], style(color=8)), 
        Line(points=[-98, -88; 56, -88], style(color=8)), 
        Line(points=[-100, -92; 56, -92], style(color=8)), 
        Line(points=[-96, -96; 56, -96], style(color=8)), 
        Ellipse(extent=[50, -80; 70, -100], style(color=10, fillColor=7)), 
        Rectangle(extent=[100, 100; 62, -100], style(
            color=7, 
            thickness=4, 
            fillColor=7)), 
        Line(points=[-80, -100; 60, -100], style(color=0, thickness=2)), 
        Rectangle(extent=[-80, 100; 60, -80], style(color=8, fillColor=8)), 
        Line(points=[-80, 100; -80, -80], style(color=0)), 
        Line(points=[-80, 100; 60, 100; 60, -80; -80, -80], style(color=0, 
              thickness=2)), 
        Text(
          extent=[-146, 178; 126, 106], 
          string="%name", 
          style(color=41, fillColor=0)), 
        Line(points=[-100, 90; -100, -92], style(color=0, thickness=2))), 
      Window(
        x=0.41, 
        y=0.23, 
        width=0.22, 
        height=0.36, 
        library=1), 
      Diagram);
  end BookExample;
  
  model RunnableExample 
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-100, 100; 100, -100], style(fillColor=7)), 
        Line(points=[-80, -84; -80, 34], style(color=0)), 
        Line(points=[-80, -84; 80, -84], style(color=0)), 
        Line(points=[-80, -44; -60, -44; -58, -36; -52, -30; -44, -28; -38, -32; 
               -34, -38; -30, -40; -28, -40; -24, -38; -20, -26; -16, -12; -12, 
               8; -6, 12; 0, 6; 0, 4; 4, -8; 6, -24; 6, -26; 8, -40; 10, -58; 
              16, -70; 26, -70; 32, -64; 36, -52; 38, -46; 44, -42; 54, -40; 62, 
               -42; 64, -46; 66, -46; 72, -46; 74, -44; 80, -44], style(color=0)), 
           
        Text(extent=[-96, 90; 96, 50], string="%name"), 
        Polygon(points=[88, -84; 68, -76; 68, -92; 88, -84], style(color=0, 
              fillColor=0)), 
        Polygon(points=[-80, 44; -88, 24; -72, 24; -80, 44], style(color=0, 
              fillColor=0))), 
      Window(
        x=0.32, 
        y=0.01, 
        width=0.48, 
        height=0.82), 
      Diagram);
    
  end RunnableExample;
end Icons;
