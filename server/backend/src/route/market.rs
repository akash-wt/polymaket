use axum::{Json, http::StatusCode};
use serde::{Deserialize, Serialize};

#[derive(Deserialize)]
struct BuyPosition {
    username: String,
}

#[derive(Serialize)]
struct BuyPositionResult {}


pub async fn sell_position() {}
pub async fn split_position() {}
pub async fn merge_position() {}
