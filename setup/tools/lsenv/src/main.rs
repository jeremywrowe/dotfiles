use std::env;
use ansi_term::Colour::Red;
use ansi_term::Colour::Yellow;
use ansi_term::Colour::Green;
use ansi_term::Colour::Blue;
use ansi_term::Colour::Purple;

fn main() {
    for (i, var) in env::vars().into_iter().enumerate() {
        let offset = i % 5;
        if offset == 0 {
            println!("{:30} {}", var.0, Red.paint(&var.1));
        } if offset == 1 {
            println!("{:30} {}", var.0, Yellow.paint(&var.1));
        } if offset == 2 {
            println!("{:30} {}", var.0, Green.paint(&var.1));
        } if offset == 3 {
            println!("{:30} {}", var.0, Blue.paint(&var.1));
        } if offset == 4 {
            println!("{:30} {}", var.0, Purple.paint(&var.1));
        }
    }
}
