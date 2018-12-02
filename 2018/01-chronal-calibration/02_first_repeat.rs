use std::fs::File;
use std::io::Read;
use std::str::FromStr;
use std::collections::HashSet;


fn read_numbers(filename: &str) -> std::io::Result<Vec<i32>> {
	let mut file = File::open(filename)?;

	let mut data = String::new();
	file.read_to_string(&mut data)?;
	
	let numbers = data.lines().map(|line|
	  i32::from_str(line).unwrap_or(0)
	).collect();
	
	Ok(numbers)
}
	
fn main() {
	
	if let Ok(numbers) = read_numbers("input.txt") {
		let mut seen = HashSet::new();
		let mut freq = 0;
		
		'out: loop {			
			for num in numbers.iter() {
				seen.insert(freq.clone());
				freq += num;
				if seen.contains(&freq) {
					break 'out;
				}
			}
		}

		println!("{:?}", freq)
	}
}