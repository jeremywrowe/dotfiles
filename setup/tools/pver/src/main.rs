use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
use regex::Regex;
use std::process;

extern crate regex;

#[macro_use]
extern crate lazy_static;

fn main() {
    lazy_static! {
        static ref RE: Regex = Regex::new(r####"^.*"version":\s"(?P<version>.*)""####).unwrap();
    }

    if let Ok(lines) = read_lines("./package.json") {
        for line in lines {
            if let Ok(ip) = line {
                for cap in RE.captures_iter(&ip) {
                    println!("{}", &cap["version"]);
                    process::exit(0);
                }
            }
        }
    }
}

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>> where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}