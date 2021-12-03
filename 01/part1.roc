app "part1"
    packages { base: "platform" }
    imports [ base.Stdout, base.Stdin, base.Task.{Task, await, succeed} ]
    provides [ main ] to base

zip2 = \l1, l2 ->
    inner = \xs, ys, acc ->
        if xs == [] then
            acc[]
        else if ys == [] then
            acc
        else
            x <- List.first xs
            y <- List.first ys
            acc <- List.append acc [x, y]
            List.append acc (inner (List.dropAt xs 0) (List.dropAt ys 0) acc)

    inner l1 l2 []

input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

main =
    _ <- await (succeed {})
    pairs = zip2 input (List.dropAt input 1)
    myStr = (List.first (List.first pairs))
    Stdout.line "You said \(mystr)"
