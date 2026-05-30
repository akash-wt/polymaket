use sqlx::{ postgres::PgPool};

#[tokio::main(flavor = "current_thread")]
async fn main() -> anyhow::Result<()> {
    let pool = PgPool::connect(&dotenvy::var("DATABASE_URL")?).await?;

    let sum = sqlx::query("SELECT 1+1 as sum").fetch_one(&pool).await?;
    println!("{:?}",sum);

    Ok(())
}
