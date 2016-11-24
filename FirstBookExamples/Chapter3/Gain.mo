within FirstBookExamples.Chapter3;
block Gain
  input Signal in_sig annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
  output Signal out_sig annotation (Placement(transformation(extent={
            {90,-10},{110,10}})));
  parameter Real K=1.0 "Gain factor";
equation
  out_sig.val = K*in_sig.val;
end Gain;
