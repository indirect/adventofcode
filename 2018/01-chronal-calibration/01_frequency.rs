use std::fs::File;
use std::io::Read;
use std::str::FromStr;

fn read(filename: &str) -> std::io::Result<String> {
	let mut file = File::open(filename)?;

	let mut data = String::new();
	file.read_to_string(&mut data)?;
	
	return Ok(data);
}
	
fn main() {
	if let Ok(str) = read("input.txt") {
		let mut freq = 0;
		for line in str.lines() {
			freq += i32::from_str(line).unwrap_or(0);
		}
		println!("{:?}", freq)
	}
}