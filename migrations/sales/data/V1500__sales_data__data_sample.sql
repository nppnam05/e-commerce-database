-- Ticket: data_sample
-- Description: data_sample
-- Schema: sales
-- Type: data
-- Date: ~0,4-~4,2-~6,2
-- Author: nppna

-- =============================================================================
-- MIGRATION: data_sample
-- =============================================================================
-- Purpose: [Detailed explanation of why this change is needed]
--
-- Impact:
--   - Tables affected: sales.[table_name]
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
-- INSERT INTO sales.table_name ("Id", "Name", "Code", "Status")
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
--         WHERE table_schema = 'sales'
--         AND table_name = 'table_name'
--         AND column_name = 'ColumnName'
--     ) THEN
--         RAISE EXCEPTION 'Migration failed: Column not created';
--     END IF;
--
--     RAISE NOTICE 'Migration completed successfully';
-- END $$;

-- Orders
INSERT INTO sales.orders ("UserId", "Code", "Address", "Status", "CreatedOn", "CreatedBy") 
VALUES (2, '#OR001', 'Ho Chi Minh', 'PND', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.orders ("UserId", "Code", "Address", "Status", "CreatedOn", "CreatedBy") 
VALUES (2, '#OR002', 'Ha Noi', 'REJ', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.orders ("UserId", "Code", "Address", "Status", "CreatedOn", "CreatedBy") 
VALUES (2, '#OR003', 'Da Nang', 'COM', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.orders ("UserId", "Code", "Address", "Status", "CreatedOn", "CreatedBy") 
VALUES (2, '#OR004', 'Can Tho', 'SHP', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');


-- Order_Products
INSERT INTO sales.order_products ("OrderId", "ProductId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (1, 1, 2, 250000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.order_products ("OrderId", "ProductId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (1, 2, 1, 270000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.order_products ("OrderId", "ProductId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (2, 1, 1, 250000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.order_products ("OrderId", "ProductId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (3, 2, 3, 270000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.order_products ("OrderId", "ProductId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (4, 1, 1, 250000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.order_products ("OrderId", "ProductId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (4, 2, 2, 270000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');

