within FirstBookExamples.Chapter6;
model BinarySystem "A binary system"
  extends FirstBookExamples.Icons.RunnableExample;
  Body sun(M=1.989e+30) annotation (extent=[-52, 28; -18, 62]);
  Body earth(
    M=5.976e+24,
    init_v={0,29.29e+3,0},
    init_x={152.1e+9,0,0}) annotation (extent=[2, 28; 36, 62]);
  GravitationalAttraction earth_sun annotation (extent=[-52, -42; -16, -8]);
equation
  connect(earth_sun.b1, sun.b) annotation (points=[-52, -25; -52, 45]);
  connect(earth_sun.b2, earth.b)
    annotation (points=[-16, -25; -6, -25; -6, 45; 2, 45]);
  annotation (experiment(StopTime=31.5581e+6),
              Commands(file="BinarySystem.mos" "Simulate BinarySystem"),
              Diagram);
end BinarySystem;
