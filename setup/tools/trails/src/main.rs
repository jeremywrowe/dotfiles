use reqwest::blocking::get;
use scraper::{Html, Selector};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let html = get("https://www.trianglemtb.com/mobiletrailstatus.php")?.text()?;
    let document = Html::parse_document(&html);
    let table_rows = Selector::parse("tbody > tr").unwrap();
    let name_column = Selector::parse("td.trail").unwrap();
    let status_column = Selector::parse("td:nth-child(2)").unwrap();

    for row in document.select(&table_rows) {
        let name = row.select(&name_column).next();
        let status = row.select(&status_column).next();
        match (name, status) {
            (Some(value), Some(value_2)) => {
                let name = value.text().next().unwrap().trim();
                let status = value_2.text().next().unwrap().trim();

                if status == "OPEN" {
                    println!("{:20} - {}", name, "✅");
                } else {
                    println!("{:20} - {}", name, "💔");
                }
                
            }
            _ => {}
        }
    }

    Ok(())
}
