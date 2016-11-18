package FirstBookExamples "Examples from the book \"Introduction to Physical Modeling with Modelica\" by Michael Tiller"










annotation (
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
"), uses(Modelica(version="3.2.2")),
  version="1",
  conversion(from(version="", script=
          "ConvertFromFirstBookExamples_.mos")));
end FirstBookExamples;
