// https://www.codewars.com/kata/exclamation-marks-series-number-1-remove-a-exclamation-mark-from-the-end-of-string/train/javascript

const remove = (s) => s.slice(-1) === '!' ? s.substring(0, s.length-1) : s
