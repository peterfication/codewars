// https://www.codewars.com/kata/triple-trouble-2/train/javascript

const tripleTrouble = (one, two, three) =>
  one.split('').reduce((acc, c, i, array) =>
    [acc, one[i], two[i], three[i]].join(''), '')
