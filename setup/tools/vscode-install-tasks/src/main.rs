extern crate dialoguer;
use dialoguer::{theme::ColorfulTheme, Select};

use std::fmt;
use std::fs::File;
use std::fs;
use std::path::Path;
use std::io::prelude::*;

struct Config {
    name: &'static str,
    value: &'static str
}

impl Config {
    fn new(name: &'static str, value: &'static str) -> Self {
        Self { name, value }
    }
}

impl fmt::Display for Config {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.name)
    }
}

fn main() -> std::io::Result<()> {
    let configs: [Config; 5] = [
        Config::new(
            "elixir",
            r#"
{
    "version": "2.0.0",
    "tasks": [
        { "label": "runTestSuite", "type": "shell", "command": "mix test", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } },
        { "label": "runCurrentTestFile", "type": "shell", "command": "mix test ${relativeFile}", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } },
        { "label": "runCurrentTest", "type": "shell", "command": "mix test ${relativeFile}:${lineNumber}", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } }
    ]
}
            "#
        ),
        Config::new(
            "ruby-minitest",
            r#"
{
    "version": "2.0.0",
    "tasks": [
        { "label": "runTestSuite", "type": "shell", "command": "bundle exec rake test", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } },
        { "label": "runCurrentTestFile", "type": "shell", "command": "bundle exec rake test TEST='${relativeFile}'", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } },
        { "label": "runCurrentTest", "type": "shell", "command": "bundle exec rake test TEST='${relativeFile}' TESTOPTS='--location=${relativeFile}:${lineNumber}'", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } }
    ]
}
            "#
        ),
        Config::new(
            "ruby-rails",
            r#"
{
    "version": "2.0.0",
    "tasks": [
        { "label": "runTestSuite", "type": "shell", "command": "./script/test", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } },
        { "label": "runCurrentTestFile", "type": "shell", "command": "rails-test ${relativeFile}", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } },
        { "label": "runCurrentTest", "type": "shell", "command": "rails-test ${relativeFile}:${lineNumber}", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } }
    ]
}
            "#
        ),
        Config::new(
            "ruby-rspec",
            r#"
{
    "version": "2.0.0",
    "tasks": [
        { "label": "runTestSuite", "type": "shell", "command": "./bin/rspec", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } },
        { "label": "runCurrentTestFile", "type": "shell", "command": "./bin/rspec ${relativeFile}", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } },
        { "label": "runCurrentTest", "type": "shell", "command": "./bin/rspec ${relativeFile}:${lineNumber}", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } }
    ]
}
            "#
        ),
        Config::new(
            "rust",
            r#"
{
    "version": "2.0.0",
    "tasks": [
        { "label": "runTestSuite", "type": "shell", "command": "cargo test", "group": "test", "presentation": { "reveal": "always", "panel": "shared" } },
    ]
}
            "#
        ),
    ];

    let selection = Select::with_theme(&ColorfulTheme::default())
        .with_prompt("What type of project?")
        .default(0)
        .items(&configs[..])
        .interact()
        .unwrap();

    let file_contents: &'static str = configs[selection].value;

    //println!("{} {}", "really?", Path::new(".vscode").join(selected_path);
    
    fs::create_dir_all(".vscode")?;
    let output_file_path = Path::new(".vscode").join("tasks.json");
    let mut output_file = match File::create(&output_file_path) {
        Err(why) => panic!("couldn't create {}: {}", output_file_path.display(), why),
        Ok(file) => file
    };

    match output_file.write_all(file_contents.as_bytes()) {
        Err(why) => panic!("couldn't write to {}: {}", output_file_path.display(), why),
        Ok(_) => Ok(())
    }
}
