use anyhow::Result;
use sqlite::Value;

pub struct CitizenData {
    pub name: String,
    pub age: i64,
    pub gender: String,
}

pub struct OfficialData {
    pub name: String,
}

pub fn get_citizen_summary(id: i64, password: String) -> Result<CitizenData> {
    let mut db_dir = dirs::home_dir().unwrap();
    db_dir.push(".vaxdbms/vax.db");

    let connection = sqlite::open(db_dir.clone()).unwrap_or_else(|_| {
        let prefix = db_dir.parent().unwrap();
        std::fs::create_dir_all(prefix).unwrap();
        std::fs::File::create(db_dir.clone())
          .expect("create failed");
        sqlite::open(db_dir).unwrap()
    });

    let mut cursor = connection
        .prepare("select name, age, gender from citizen where id=? and password=?")
        .unwrap()
        .into_cursor();
    cursor.bind(&[Value::Integer(id),Value::String(password)]).unwrap();

    if let Some(row) = cursor.next().unwrap() {
        let _a = CitizenData {
            name: row[0].as_string().unwrap().to_string(),
            age: row[1].as_integer().unwrap(),
            gender: row[2].as_string().unwrap().to_string(),
        };
        Ok(_a)
    } else {
        Err(anyhow::Error::msg("Entry not found!"))
    }
}

pub fn get_official_summary(id: i64, password: String) -> Result<OfficialData> {
    let mut db_dir = dirs::home_dir().unwrap();
    db_dir.push(".vaxdbms/vax.db");

    let connection = sqlite::open(db_dir.clone()).unwrap_or_else(|_| {
        let prefix = db_dir.parent().unwrap();
        std::fs::create_dir_all(prefix).unwrap();
        std::fs::File::create(db_dir.clone())
          .expect("create failed");
        sqlite::open(db_dir).unwrap()
    });

    let mut cursor = connection
        .prepare("select name from official where id=? and password=?")
        .unwrap()
        .into_cursor();
    cursor.bind(&[Value::Integer(id),Value::String(password)]).unwrap();

    if let Some(row) = cursor.next().unwrap() {
        let _a = OfficialData {
            name: row[0].as_string().unwrap().to_string(),
        };
        Ok(_a)
    } else {
        Err(anyhow::Error::msg("Entry not found!"))
    }
}

#[cfg(test)]
mod tests {
    use super::get_citizen_summary;
    use super::get_official_summary;

    #[test]
    fn test() {
        get_citizen_summary(1,String::from("pass")).unwrap();
        get_official_summary(1, String::from("pass")).unwrap();
    }
}
