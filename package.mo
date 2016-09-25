package BookExamples "Examples from the book \"Introduction to Physical Modeling with Modelica\" by Michael Tiller"
annotation (
  Dymola(checkSum="46717907:1185437955"),
  Coordsys(
    extent=[0, 0; 313, 183], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.01, 
    y=0.62, 
    width=0.31, 
    height=0.3, 
    library=1, 
    autolayout=1), 
  Documentation(info="The \"BookExamples\" package includes all the
examples (and component models) from the book \"Introduction
to Physical Modeling with Modelica\" by Michael Tiller.

The models are organized by what chapter they appear in.  Models that
can be translated and run are indicated with a special icon that looks
like a plot.

These models are meant to enhance the content of the book but they
should not be considered a substitute for reading the book.

Updated 25 September 2001 to use 'each' for array of components,
and use array of components to simplify the example Chapter9/ParticleBeam.
"));
end BookExamples;
