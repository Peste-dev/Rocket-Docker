#[macro_use]
extern crate rocket;

#[launch]
async fn rocket() -> _ {
	rocket::build()
        .mount("/", routes![index])
}

#[get("/")]
pub(crate) async fn index() -> String {
    "Hello, world!".to_string()
}
