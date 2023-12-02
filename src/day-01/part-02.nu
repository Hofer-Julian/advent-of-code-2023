use std

def part-two [] {
    lines | each { calibration-value } | math sum
}

def calibration-value [] {
    let chars = str replace one "1" 
        | str replace two "2" 
        | str replace three "3"
        | str replace four "4"
        | str replace five "5"
        | str replace six "6"
        | str replace seven "7"
        | str replace eight "8"
        | str replace nine "9"
        | inspect
        | split chars
    let match = {|c| $c =~ '\d'}
    let first = $chars | skip until $match | first
    let last = $chars | reverse | skip until $match | first
    $"($first)($last)" | into int
}

let input = "two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen"

std assert equal ($input | part-two) 281
