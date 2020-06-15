use std::env;
use std::vec::Vec;
use ansi_term::Colour::Red;
use ansi_term::Colour::Yellow;
use ansi_term::Colour::Green;
use ansi_term::Colour::Blue;
use ansi_term::Colour::Purple;
use atty::Stream;

fn main() {
    let path: String = env::var("PATH")
        .expect("Expected to find path env variable");
    let entries: Vec<&str> = path.split(":").collect();
    
    for (i, entry) in entries.iter().enumerate() {
        let breakdown: Vec<&str> = entry.split("/").collect();
        if !atty::is(Stream::Stdout) {
            println!("{}", entry);
            continue;
        }

        let mut output: Vec<String> = Vec::new();
        for item in breakdown.iter() {
            let offset = i % 5;
            if offset == 0 {
                output.push(format!("{}", Red.paint(*item)));
            } if offset == 1 {
                output.push(format!("{}", Yellow.paint(*item)));
            } if offset == 2 {
                output.push(format!("{}", Green.paint(*item)));
            } if offset == 3 {
                output.push(format!("{}", Blue.paint(*item)));
            } if offset == 4 {
                output.push(format!("{}", Purple.paint(*item)));
            }
        }

        println!("{}", output.join("/"));
    }
}
