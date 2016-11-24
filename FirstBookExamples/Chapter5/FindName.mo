within FirstBookExamples.Chapter5;
function FindName
  extends Modelica.Icons.Function;
  input String names[:];
  input String name_to_find;
  output Integer index;
protected
  Integer i;
  Integer len=size(names, 1);
algorithm
  index := -1;
  i := 1;
  while index == -1 and i <= len loop
    if names[i] == name_to_find then
      index := i;
    end if;
    i := i + 1;
  end while;
  assert(index <> -1, "FindName: failed");
end FindName;
