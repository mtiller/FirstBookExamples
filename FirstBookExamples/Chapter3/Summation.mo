within FirstBookExamples.Chapter3;
block Summation
  input Signal in_sig1 annotation (Placement(transformation(extent={{
            -110,10},{-90,30}})));
  input Signal in_sig2 annotation (Placement(transformation(extent={{
            90,10},{110,30}})));
  output Signal out_sig annotation (Placement(transformation(extent={
            {-110,-30},{-90,-10}})));
  parameter Real scale1=1.0 "Scale factor 1";
  parameter Real scale2=1.0 "Scale factor 2";
equation
  out_sig.val = scale1*in_sig1.val + scale2*in_sig2.val;
end Summation;
