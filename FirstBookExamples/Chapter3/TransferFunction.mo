within FirstBookExamples.Chapter3;
block TransferFunction
  input Signal in_sig annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
  output Signal out_sig annotation (Placement(transformation(extent={
            {90,-10},{110,10}})));
  parameter Real c1=0.8;
  parameter Real c2=0.1;
equation
  c1*der(out_sig.val) + c2*out_sig.val = in_sig.val;
end TransferFunction;
