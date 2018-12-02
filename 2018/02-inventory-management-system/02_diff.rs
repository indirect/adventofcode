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
	
	'done: for i in 0..ids.len() {
		for n in (i+1)..ids.len() {
			let diffs = ids[i].chars().zip(ids[n].chars()).filter(|(c1, c2)| c1 != c2 ).collect::<Vec<_>>();
			if diffs.len() == 1 {
				let same = ids[i].chars().zip(ids[n].chars()).filter_map(|(c1,c2)| match c1 == c2 { true => Some(c1), false => None } ).collect::<String>();
				println!("{}", same);
				break 'done;
			}
		}
	}
	
	Ok(())
}