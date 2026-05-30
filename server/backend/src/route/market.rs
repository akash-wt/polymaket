use axum::{Json, http::StatusCode};
use serde::Deserialize;

#[derive(Deserialize)]
struct BuyPosition {
    username: String,
}

pub async fn buy_position(Json(payload): Json<BuyPosition>)  
// -> (StatusCode)
 {

 }

pub async fn sell_position() {}
pub async fn split_position() {}
pub async fn merge_position() {}
