-- +goose Up
CREATE TABLE audit_log (
    id BIGSERIAL PRIMARY KEY,
    actor_id UUID NOT NULL,
    action VARCHAR(50) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    entity_id UUID NOT NULL,
    old_state JSONB,
    new_state JSONB,
    metadata JSONB,
    ip_address VARCHAR(45),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_audit_actor_id    ON audit_log(actor_id);
CREATE INDEX idx_audit_entity      ON audit_log(entity_type, entity_id);
CREATE INDEX idx_audit_action      ON audit_log(action);
CREATE INDEX idx_audit_created     ON audit_log(created_at DESC);

-- +goose Down
DROP TABLE audit_log;
DROP INDEX idx_audit_actor_id;
DROP INDEX idx_audit_entity;
DROP INDEX idx_audit_action;
DROP INDEX idx_audit_created;
