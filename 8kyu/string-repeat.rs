// https://www.codewars.com/kata/string-repeat/train/rust

fn repeat_str(src: &str, count: usize) -> String {
  let mut out = String::new();
  for x in 0..count {
    out.push_str(src)
  }
  out
}
