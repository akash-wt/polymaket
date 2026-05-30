use axum::{
    Router,
    routing::{get, post},
};

mod route;
use crate::route::market::{buy_position, merge_position, sell_position, split_position};
use crate::route::user::{user_balance, user_position_history, user_positoins};

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();

    let app = Router::new()
        .route("/buy", post(buy_position))
        .route("/sell", post(sell_position))
        .route("/split", post(split_position))
        .route("/merge", post(merge_position))
        .route("/balance", get(user_balance))
        .route("/positions", get(user_positoins))
        .route("/history", get(user_position_history));

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}
