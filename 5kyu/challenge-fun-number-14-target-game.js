// https://www.codewars.com/kata/challenge-fun-number-14-target-game/train/javascript
// Does not work for big inputs :/
function targetGame(vals) {
  vals = vals.map(val => Math.max(val, 0))
  if (vals.length == 0) { return 0 }
  if (vals.length == 1) { return vals[0] > 0 ? vals[0] : 0 }
  if (vals.length <= 3) { return calculateMax(vals) }

  let splitIndex = Math.ceil((vals.length-1)/2)

  let valsFirst = vals.slice(0, splitIndex)
  let valsSecond = vals.slice(splitIndex, vals.length)

  let x1 = calculateMax(valsFirst)
  let x2 = calculateMax(valsFirst.slice(0, -1))
  let y1 = calculateMax(valsSecond)
  let y2 = calculateMax(valsSecond.slice(1, valsSecond.length))
  let xy1 = x1 + y2
  let xy2 = x2 + y1

  return Math.max(xy1, xy2)
}

function calculateMax(vals) {
  let sums = getIndexCombinations(vals.length).map(combination => {
    return combination.reduce((acc, index) => acc += vals[index - 1], 0)
  })

  return Math.max(...sums)
}


function getIndexCombinations(length) {
  let combinations = []

  for (var i = 1; i <= length; i++) {
    combinations = expandCombinations(combinations, i)
  }

  return combinations

  // Remove unnecessary combinations (like [1] when there is [1, 3])
  combinations = combinations.filter(x => {
    let out = true

    for (let combination of combinations) {
      if (x != combination && x.length < combination.length) {
        out = !x.every((element, index, array) => element == combination[index])
        if (!out) { break }
      }
    }

    return out
  })

  return combinations
}

function expandCombinations(combinations, i) {
  for (let key in combinations) {
    let calc = i - combinations[key][combinations[key].length - 1]
    if (calc == 2) {
      combinations.push(combinations[key].concat(i))
    } else if (calc == 3) {
      combinations.push(combinations[key].concat(i))
    }
  }

  if (i < 3) {
    return combinations.concat([[i]])
  } else {
    return combinations
  }
}
