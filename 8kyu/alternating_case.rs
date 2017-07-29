// https://www.codewars.com/kata/alternating-case-%3C-equals-%3E-alternating-case/train/rust

fn to_alternating_case(s: &str) -> String {
   let mut out = String::new();

   for c in s.chars() {
       if c == c.to_uppercase().next().unwrap() {
         out.push(c.to_lowercase().next().unwrap());
       } else {
         out.push(c.to_uppercase().next().unwrap());
       }
   }

   out
}
