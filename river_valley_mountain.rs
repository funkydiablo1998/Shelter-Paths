// ShelterPaths.rs

// module declaration
mod ShelterPaths {
    // imports
    use std::fs;
    use std::io;
    use std::path::Path;
    use std::fs::OpenOptions;

    // function to create a folder for shelter paths
    pub fn create_shelter_paths_folder(path: &str) -> io::Result<()> {
        let created_path = Path::new(path);
        fs::create_dir_all(&created_path)?;
        Ok(())
    }

    // function to create a new shelter path
    pub fn create_new_shelter_path(
        directory: &str,
        name: &str,
        address: &str,
    ) -> io::Result<()> {
        let shelter_path_path = Path::new(directory).join(name);
        let mut shelter_path_file = OpenOptions::new()
            .write(true)
            .create(true)
            .open(shelter_path_path)?;

        shelter_path_file.write_all(address.as_bytes())?;

        Ok(())
    }

    // function to list all the shelter paths
    pub fn list_shelter_paths(directory: &str) -> io::Result<Vec<String>> {
        let mut shelter_path_names: Vec<String> = Vec::new();
        for entry in fs::read_dir(directory)? {
            let entry = entry?;
            let path = entry.path();
            shelter_path_names.push(String::from(path.to_str().unwrap()));
        }

        Ok(shelter_path_names)
    }

    // function to update an existig shelter path
    pub fn update_shelter_path(
        directory: &str,
        name: &str,
        new_address: &str,
    ) -> io::Result<()> {
        let shelter_path_path = Path::new(directory).join(name);
        let mut shelter_path_file = OpenOptions::new()
            .write(true)
            .open(shelter_path_path)?;

        shelter_path_file.write_all(new_address.as_bytes())?;

        Ok(())
    }

    // function to delete an existing shelter path
    pub fn delete_shelter_path(directory: &str, name: &str) -> io::Result<()> {
        fs::remove_file(Path::new(directory).join(name))?;

        Ok(())
    }

}