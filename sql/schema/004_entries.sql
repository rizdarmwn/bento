-- +goose Up
CREATE TABLE entries(
    id BIGSERIAL PRIMARY KEY,
    transfer_id UUID NOT NULL,
    account_id UUID NOT NULL,
    amount BIGINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT amount_not_zero CHECK (amount <> 0),
    CONSTRAINT fk_transfer_id FOREIGN KEY (transfer_id) REFERENCES transfers(id),
    CONSTRAINT fk_account_id FOREIGN KEY (account_id) REFERENCES accounts(id)
);

CREATE INDEX idx_entries_account_id   ON entries(account_id);
CREATE INDEX idx_entries_transfer_id  ON entries(transfer_id);
CREATE INDEX idx_entries_account_created ON entries(account_id, created_at DESC);

-- +goose Down
DROP TABLE entries;
DROP INDEX idx_entries_account_id;
DROP INDEX idx_entries_transfer_id;
DROP INDEX idx_entries_account_created;
