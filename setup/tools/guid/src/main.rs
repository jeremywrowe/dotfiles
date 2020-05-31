use uuid::Uuid;
use std::env;
use ansi_term::Colour::Purple;
use ansi_term::Colour::Yellow;
use atty::Stream;

fn main() {
    let args: Vec<String> = env::args().collect();
    let uuid: String = format!("{}", Uuid::new_v4());
    let mut prefix = "";

    if args.len() >= 2 {
        prefix = &args[1];
    }

    if atty::is(Stream::Stdout) {
        println!("{}{}", Purple.paint(prefix), Yellow.paint(&uuid[prefix.len()..uuid.len()]));
    } else {
        println!("{}{}", prefix, &uuid[prefix.len()..uuid.len()]);
    }
}
