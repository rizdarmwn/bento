-- +goose Up
CREATE TABLE transfers (
    id UUID PRIMARY KEY DEFAULT uuidv7(),
    from_account_id UUID NOT NULL REFERENCES accounts(id),
    to_account_id UUID NOT NULL REFERENCES accounts(id),
    amount BIGINT NOT NULL,
    currency VARCHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    idempotency_key VARCHAR(255) NOT NULL UNIQUE,
    metadata JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT amount_positive CHECK (amount > 0),
    CONSTRAINT different_accounts CHECK (from_account_id <> to_account_id),
    CONSTRAINT currency_uppercase CHECK (currency = UPPER(currency))
);

CREATE INDEX idx_transfers_from_account ON transfers(from_account_id);
CREATE INDEX idx_transfers_to_account   ON transfers(to_account_id);
CREATE INDEX idx_transfers_idempotency  ON transfers(idempotency_key);
CREATE INDEX idx_transfers_status       ON transfers(status);
CREATE INDEX idx_transfers_created      ON transfers(created_at DESC);

-- +goose Down
DROP TABLE transfers;
DROP INDEX idx_transfers_created;
DROP INDEX idx_transfers_from_account;
DROP INDEX idx_transfers_idempotency;
DROP INDEX idx_transfers_status;
DROP INDEX idx_transfers_created;
