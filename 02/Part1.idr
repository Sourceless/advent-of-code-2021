module Part1

data SubmarineState = SS Integer Integer

Show SubmarineState where
  show (SS x y) = "[ distance: " ++ show x ++ ", depth: " ++ show y ++ " ]"

initial : SubmarineState
initial = SS 0 0

forward : Integer -> SumbarineState -> SubmarineState
forward n (SS x y) = SS (x + n) y

up : Integer -> SumbarineState -> SubmarineState
up n (SS x y) = SS x (y - n)

down : integer -> sumbarinestate -> submarinestate
down n (ss x y) = ss x (y + n)

input : SumbarineState -> SubmarineState
input =


main : IO ()
main = printLn initial
