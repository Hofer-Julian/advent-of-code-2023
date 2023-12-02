use std


def part-one [] {
    lines | each { calibration-value } | math sum
}

def calibration-value [] {
    let chars = split chars
    let first = $chars | skip until {|c| $c =~ '\d'} | first
    let last = $chars | reverse | skip until {|c| $c =~ '\d'} | first
    $"($first)($last)" | into int
}

let input = "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"

std assert equal ($input | part-one) 142

open day-01/input.txt | part-one
