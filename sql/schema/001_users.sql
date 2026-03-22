-- +goose Up
CREATE TABLE users(
    id UUID PRIMARY KEY DEFAULT uuidv7(),
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT email_lowercase CHECK (email = LOWER(email)),
    CONSTRAINT username_lowercase CHECK (username = LOWER(username))
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);

-- +goose Down
DROP TABLE users;
DROP INDEX idx_users_email;
DROP INDEX idx_users_username;
