-- Add migration script here

CREATE EXTENSION IF NOT EXISTS "pgcrypto"; -- for gen_random_uuid()

CREATE TYPE order_type AS ENUM ('Buy', 'Sell', 'Split', 'Merge');
CREATE TYPE position_type AS ENUM ('Yes', 'No');

CREATE TABLE "user" (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    address     TEXT        NOT NULL UNIQUE,
    usd_balance INT         NOT NULL DEFAULT 0
);

CREATE INDEX idx_user_address ON "user"(address);

CREATE TABLE market (
    id                      UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    title                   TEXT        NOT NULL,
    description             TEXT        NOT NULL,
    resolution_description  TEXT        NOT NULL,
    yes_orderbook           JSONB       NOT NULL DEFAULT '{}',
    no_orderbook            JSONB       NOT NULL DEFAULT '{}',
    total_qty               INT         NOT NULL DEFAULT 0,
    resolution              position_type
);

CREATE TABLE position (
    id          UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id     UUID            NOT NULL REFERENCES "user"(id),
    market_id   UUID            NOT NULL REFERENCES market(id),
    type        position_type   NOT NULL,
    qty         INT             NOT NULL DEFAULT 0,
    UNIQUE(user_id, market_id, type)
);

CREATE TABLE order_history (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    order_type  order_type  NOT NULL,
    qty         INT         NOT NULL,
    price       INT         NOT NULL,
    user_id     UUID        NOT NULL REFERENCES "user"(id),
    market_id   UUID        NOT NULL REFERENCES market(id)
);