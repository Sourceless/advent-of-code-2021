app "part1"
    packages { pf: "platform" }
    imports [ pf.Stdout ]
    provides [ main ] to pf

main = Stdout.line "hello world"
