-- +goose Up
CREATE TABLE accounts(
    id UUID PRIMARY KEY DEFAULT uuidv7(),
    owner_id UUID,
    balance BIGINT NOT NULL DEFAULT 0,
    currency VARCHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES users(id),
    CONSTRAINT balance_non_negative CHECK (balance >= 0),
    CONSTRAINT currency_uppercase CHECK (currency = UPPER(currency))
);

CREATE INDEX idx_accounts_owner_id ON accounts(owner_id);
CREATE INDEX idx_accounts_currency ON accounts(currency);

-- +goose Down
DROP TABLE accounts;
DROP INDEX idx_accounts_owner_id;
DROP INDEX idx_accounts_currency;
