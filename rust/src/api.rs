use anyhow::Result;
use sqlite::Value;

pub struct CitizenData {
    pub name: String,
    pub age: i64,
    pub gender: String,
    pub sick_no: i64,
    pub tot_citizens: i64,
    pub a_date: Option<i64>,
    pub a_name: Option<String>,
    pub a_location: Option<String>,
}

pub struct OfficialData {
    pub name: String,
}

pub struct ID {
    pub id: i64,
}

pub fn add_citizen(name: String, password: String, age: i64, gender: String) -> Result<ID> {
    let mut db_dir = dirs::home_dir().unwrap();
    db_dir.push(".vaxdbms/vax.db");

    let connection = sqlite::open(db_dir.clone()).unwrap_or_else(|_| {
        let prefix = db_dir.parent().unwrap();
        std::fs::create_dir_all(prefix).unwrap();
        std::fs::File::create(db_dir.clone()).expect("create failed");
        sqlite::open(db_dir).unwrap()
    });

    let mut cursor = connection
        .prepare("insert into citizen (name, password, age, gender) values (?,?,?,?)")
        .unwrap()
        .into_cursor();
    cursor
        .bind(&[
            Value::String(name),
            Value::String(password),
            Value::Integer(age),
            Value::String(gender),
        ])
        .unwrap();

    match cursor.next() {
        Ok(_) => {
            let mut cursor = connection
                .prepare("select max(id) from citizen")
                .unwrap()
                .into_cursor();
            let row = cursor.next().unwrap().unwrap();
            Ok(ID {
                id: row[0].as_integer().unwrap(),
            })
        }
        Err(_) => Err(anyhow::Error::msg("Couldn't insert!")),
    }
}

pub fn add_appoinment(citizen_id: i64, center_id: i64, date: i64) -> Result<()> {
    let mut db_dir = dirs::home_dir().unwrap();
    db_dir.push(".vaxdbms/vax.db");

    let connection = sqlite::open(db_dir.clone()).unwrap_or_else(|_| {
        let prefix = db_dir.parent().unwrap();
        std::fs::create_dir_all(prefix).unwrap();
        std::fs::File::create(db_dir.clone()).expect("create failed");
        sqlite::open(db_dir).unwrap()
    });

    let mut cursor = connection
        .prepare("insert into appoinment (citizenid, centerid, date) values (?,?,?)")
        .unwrap()
        .into_cursor();
    cursor
        .bind(&[Value::Integer(citizen_id), Value::Integer(center_id), Value::Integer(date)])
        .unwrap();

    match cursor.next() {
        Ok(_) => {
          Ok(())
        }
        Err(_) => Err(anyhow::Error::msg("Couldn't create appoinment!")),
    }
}

pub fn add_vaccination_center(name: String, location: String) -> Result<ID> {
    let mut db_dir = dirs::home_dir().unwrap();
    db_dir.push(".vaxdbms/vax.db");

    let connection = sqlite::open(db_dir.clone()).unwrap_or_else(|_| {
        let prefix = db_dir.parent().unwrap();
        std::fs::create_dir_all(prefix).unwrap();
        std::fs::File::create(db_dir.clone()).expect("create failed");
        sqlite::open(db_dir).unwrap()
    });

    let mut cursor = connection
        .prepare("insert into vaxcenter (name, location) values (?,?)")
        .unwrap()
        .into_cursor();
    cursor
        .bind(&[Value::String(name), Value::String(location)])
        .unwrap();

    match cursor.next() {
        Ok(_) => {
            let mut cursor = connection
                .prepare("select max(centerid) from vaxcenter")
                .unwrap()
                .into_cursor();
            let row = cursor.next().unwrap().unwrap();
            Ok(ID {
                id: row[0].as_integer().unwrap(),
            })
        }
        Err(_) => Err(anyhow::Error::msg("Couldn't insert!")),
    }
}

pub fn get_vax_centers() -> Result<Vec<String>> {
    let mut db_dir = dirs::home_dir().unwrap();
    db_dir.push(".vaxdbms/vax.db");

    let connection = sqlite::open(db_dir.clone()).unwrap_or_else(|_| {
        let prefix = db_dir.parent().unwrap();
        std::fs::create_dir_all(prefix).unwrap();
        std::fs::File::create(db_dir.clone()).expect("create failed");
        sqlite::open(db_dir).unwrap()
    });

    let mut cursor = connection
        .prepare("select name, centerid from vaxcenter")
        .unwrap()
        .into_cursor();

    let mut centers: Vec<String> = Vec::new();

    if let Some(row) = cursor.next().unwrap() {
        let mut center = String::new();
        center.push_str(row[1].as_integer().unwrap().to_string().as_str());
        center.push_str(": ");
        center.push_str(row[0].as_string().unwrap());
        centers.push(center);
        while let Some(row2) = cursor.next().unwrap() {
            let mut center = String::new();
        center.push_str(row2[1].as_integer().unwrap().to_string().as_str());
            center.push_str(": ");
            center.push_str(row2[0].as_string().unwrap());
            centers.push(center);
        }
        Ok(centers)
    } else {
        Err(anyhow::Error::msg("No centers!"))
    }
}

pub fn add_official(name: String, password: String) -> Result<ID> {
    let mut db_dir = dirs::home_dir().unwrap();
    db_dir.push(".vaxdbms/vax.db");

    let connection = sqlite::open(db_dir.clone()).unwrap_or_else(|_| {
        let prefix = db_dir.parent().unwrap();
        std::fs::create_dir_all(prefix).unwrap();
        std::fs::File::create(db_dir.clone()).expect("create failed");
        sqlite::open(db_dir).unwrap()
    });

    let mut cursor = connection
        .prepare("insert into official (name, password) values (?,?)")
        .unwrap()
        .into_cursor();
    cursor
        .bind(&[Value::String(name), Value::String(password)])
        .unwrap();

    match cursor.next() {
        Ok(_) => {
            let mut cursor = connection
                .prepare("select max(id) from official")
                .unwrap()
                .into_cursor();
            let row = cursor.next().unwrap().unwrap();
            Ok(ID {
                id: row[0].as_integer().unwrap(),
            })
        }
        Err(_) => Err(anyhow::Error::msg("Couldn't insert!")),
    }
}

pub fn get_citizen_summary(id: i64, password: String) -> Result<CitizenData> {
    let mut db_dir = dirs::home_dir().unwrap();
    db_dir.push(".vaxdbms/vax.db");

    let connection = sqlite::open(db_dir.clone()).unwrap_or_else(|_| {
        let prefix = db_dir.parent().unwrap();
        std::fs::create_dir_all(prefix).unwrap();
        std::fs::File::create(db_dir.clone()).expect("create failed");
        sqlite::open(db_dir).unwrap()
    });

    let mut cursor = connection
        .prepare("select name, age, gender from citizen where id=? and password=?")
        .unwrap()
        .into_cursor();
    cursor
        .bind(&[Value::Integer(id), Value::String(password)])
        .unwrap();

    let mut cursor2 = connection
        .prepare("select count(id) from citizen where is_sick=?")
        .unwrap()
        .into_cursor();
    cursor2.bind(&[Value::String(String::from("Y"))]).unwrap();

    let mut cursor3 = connection
        .prepare("select count(id) from citizen")
        .unwrap()
        .into_cursor();
    
    let mut cursor4 = connection
        .prepare("select vaxcenter.name, vaxcenter.location, appoinment.date from vaxcenter inner join appoinment on appoinment.centerid = vaxcenter.centerid where appoinment.citizenid=? order by date desc")
        .unwrap()
        .into_cursor();
    cursor4.bind(&[Value::Integer(id)]).unwrap();

    if let Some(row) = cursor.next().unwrap() {
        if let Some(row2) = cursor2.next().unwrap() {
            if let Some(row3) = cursor3.next().unwrap() {
            if let Some(row4) = cursor4.next().unwrap() {
                Ok(CitizenData {
                    name: row[0].as_string().unwrap().to_string(),
                    age: row[1].as_integer().unwrap(),
                    gender: row[2].as_string().unwrap().to_string(),
                    sick_no: row2[0].as_integer().unwrap(),
                    tot_citizens: row3[0].as_integer().unwrap(),
                    a_name: Some(row4[0].as_string().unwrap().to_string()),
                    a_location: Some(row4[1].as_string().unwrap().to_string()),
                    a_date: Some(row4[2].as_integer().unwrap()),
                })
            } else {
                Ok(CitizenData {
                    name: row[0].as_string().unwrap().to_string(),
                    age: row[1].as_integer().unwrap(),
                    gender: row[2].as_string().unwrap().to_string(),
                    sick_no: row2[0].as_integer().unwrap(),
                    tot_citizens: row3[0].as_integer().unwrap(),
                    a_name: None,
                    a_location: None,
                    a_date: None,
                })
            }

            } else {
                Err(anyhow::Error::msg("No citizen records!"))
            }
        } else {
            Err(anyhow::Error::msg("No citizen records!"))
        }
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
        std::fs::File::create(db_dir.clone()).expect("create failed");
        sqlite::open(db_dir).unwrap()
    });

    let mut cursor = connection
        .prepare("select name from official where id=? and password=?")
        .unwrap()
        .into_cursor();
    cursor
        .bind(&[Value::Integer(id), Value::String(password)])
        .unwrap();

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
    use super::add_appoinment;
    use super::add_citizen;
    use super::add_official;
    use super::add_vaccination_center;
    use super::get_citizen_summary;
    use super::get_official_summary;
    use super::get_vax_centers;

    #[test]
    fn test() {
        get_citizen_summary(1, String::from("pass")).unwrap();
        get_official_summary(1, String::from("pass")).unwrap();
        add_citizen(
            String::from("Dinah"),
            String::from("pass"),
            3,
            String::from("F"),
        )
        .unwrap();
        add_official(String::from("Off"), String::from("pass")).unwrap();
        add_vaccination_center(String::from("MEC"), String::from("Kochi")).unwrap();
        get_vax_centers().unwrap();
        add_appoinment(4, 3, 1).unwrap();
    }
}
