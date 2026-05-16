-- Ticket: 1
-- Description: add_data_to_user_and_role
-- Schema: identity
-- Type: data
-- Date: ~0,4-~4,2-~6,2
-- Author: nppna

-- =============================================================================
-- MIGRATION: add_data_to_user_and_role
-- =============================================================================
-- Purpose: [Detailed explanation of why this change is needed]
--
-- Impact:
--   - Tables affected: identity.[table_name]
--   - Estimated execution time: [X seconds]
--   - Backward compatible: [Yes/No]
--   - Requires data migration: [Yes/No]
--
-- Testing:
--   - [ ] Tested on local database
--   - [ ] Verified with existing data
--   - [ ] Application tested
--
-- Rollback:
--   - Method: Create new migration to undo
-- =============================================================================

-- =============================================================================
-- DATA MIGRATION - Seed Data / Updates
-- =============================================================================

-- Example: Seed Data
-- INSERT INTO identity.table_name ("Id", "Name", "Code", "Status")
-- VALUES
--     (1, 'Value 1', 'CODE1', 'ACT'),
--     (2, 'Value 2', 'CODE2', 'ACT')
-- ON CONFLICT ("Id") DO UPDATE
-- SET
--     "Name" = EXCLUDED."Name",
--     "Code" = EXCLUDED."Code",
--     "Status" = EXCLUDED."Status",
--     "ModifiedOn" = CURRENT_TIMESTAMP,
--     "ModifiedBy" = 'system';

-- Add your data migration SQL here:


-- =============================================================================
-- POST-MIGRATION VALIDATION
-- =============================================================================

-- DO $$
-- BEGIN
--     IF NOT EXISTS (
--         SELECT 1 FROM information_schema.columns
--         WHERE table_schema = 'identity'
--         AND table_name = 'table_name'
--         AND column_name = 'ColumnName'
--     ) THEN
--         RAISE EXCEPTION 'Migration failed: Column not created';
--     END IF;
--
--     RAISE NOTICE 'Migration completed successfully';
-- END $$;

-- ROLE

INSERT INTO "identity"."roles" ("Id", "Name", "Description", "Status", "CreatedOn", "CreatedBy", "ModifiedOn", "ModifiedBy") VALUES (2, 'USER', 'user', 'ACT', '2026-05-16 13:32:06', 'SYSTEM', '2026-05-16 13:32:22', 'SYSTEM');
INSERT INTO "identity"."roles" ("Id", "Name", "Description", "Status", "CreatedOn", "CreatedBy", "ModifiedOn", "ModifiedBy") VALUES (1, 'ADMIN', 'admin', 'ACT', '2026-05-16 13:32:06', 'SYSTEM', '2026-05-16 13:32:22', 'SYSTEM');


-- USER
INSERT INTO "identity"."users" ("Id", "Email", "RoleId", "Phone", "Location", "DisplayName", "Avatar", "PasswordHash", "FailedLoginAttempts", "Status", "CreatedOn", "CreatedBy", "ModifiedOn", "ModifiedBy") VALUES (1, 'admin@gmail.com', 1, '0999999999', 'a', 'Admin', NULL, '$2a$10$f4qzCvnpNexeH/d7echGxOVydZw34WsT7j/PjnX0XCsHXarUtOZlG', 0, 'ACT', '2026-05-16 15:21:38.255637', 'SYSTEM', '2026-05-16 15:21:38.255637', 'SYSTEM');
