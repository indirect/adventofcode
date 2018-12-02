use std::fs::File;
use std::io::Read;
use std::io::Result;

fn read_numbers(filename: &str) -> Result<Vec<String>> {
	let mut file = File::open(filename)?;

	let mut data = String::new();
	file.read_to_string(&mut data)?;
		
	let lines = data.lines().map(|l| String::from(l) ).collect();
		
	Ok(lines)
}

fn main() -> Result<()> {
	let ids = read_numbers("input.txt")?;
	let mut twos = 0;
	let mut threes = 0;
	
	for i in 0..ids.len() {
		let counts = ids[i].chars().
			map(|c| ids[i].match_indices(c) ).
			map(|mi| mi.map(|(i,_)| i ).collect::<Vec<_>>() ).
			collect::<Vec<_>>();
		
		if counts.iter().any(|a| a.len() == 2 ) {
			twos += 1;
		}
		if counts.iter().any(|a| a.len() == 3 ) {
			threes += 1;
		}

	}
	
	println!("{}", twos * threes);
	
	Ok(())
}