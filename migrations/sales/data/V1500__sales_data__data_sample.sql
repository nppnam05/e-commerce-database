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
-- Đơn số 1: Đơn mới lập, đang chờ xử lý và khách CHƯA thanh toán (Hoặc đang chờ quét mã)
INSERT INTO sales.orders ("UserId", "AddressId", "Code", "TotalQuantity", "TotalPrice", "Status", "PaymentStatus", "PaymentLinkId", "CreatedOn", "CreatedBy") 
VALUES (2, 1, '#OR001', 3, 770000.00, 'PND', 'PND', 'link_payos_001', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');

-- Đơn số 2: Đơn bị Admin từ chối (REJ) vì một lý do nào đó (ví dụ: hết hàng) cho dù khách ĐÃ trả tiền rồi
INSERT INTO sales.orders ("UserId", "AddressId", "Code", "TotalQuantity", "TotalPrice", "Status", "PaymentStatus", "PaymentLinkId", "CreatedOn", "CreatedBy") 
VALUES (2, 1, '#OR002', 1, 250000.00, 'REJ', 'PAID', 'link_payos_002', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');

-- Đơn số 3: Đơn hàng hoàn thành trọn vẹn, đã giao tới tay khách và tiền ĐÃ thu xong
INSERT INTO sales.orders ("UserId", "AddressId", "Code", "TotalQuantity", "TotalPrice", "Status", "PaymentStatus", "PaymentLinkId", "CreatedOn", "CreatedBy") 
VALUES (2, 2, '#OR003', 3, 810000.00, 'COM', 'PAID', 'link_payos_003', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');

-- Đơn số 4: Đơn đang đi giao, tiền thì shop ĐÃ thu trước qua PayOS rồi mới xuất kho
INSERT INTO sales.orders ("UserId", "AddressId", "Code", "TotalQuantity", "TotalPrice", "Status", "PaymentStatus", "PaymentLinkId", "CreatedOn", "CreatedBy") 
VALUES (2, 2, '#OR004', 3, 790000.00, 'SHP', 'PAID', 'link_payos_004', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');

-- Đơn số 5 (BỔ SUNG): Khách chủ động bấm HỦY ĐƠN (CNL) khi chưa kịp thanh toán (Hết hạn link / Hoặc đổi ý)
INSERT INTO sales.orders ("UserId", "AddressId", "Code", "TotalQuantity", "TotalPrice", "Status", "PaymentStatus", "PaymentLinkId", "CreatedOn", "CreatedBy") 
VALUES (2, 1, '#OR005', 2, 450000.00, 'CNL', 'CNL', 'link_payos_005', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');


-- Order_Products
INSERT INTO sales.order_products ("OrderId", "ProductChildrenId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (1, 1, 2, 250000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.order_products ("OrderId", "ProductChildrenId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (1, 2, 1, 270000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.order_products ("OrderId", "ProductChildrenId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (2, 1, 1, 250000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.order_products ("OrderId", "ProductChildrenId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (3, 2, 3, 270000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.order_products ("OrderId", "ProductChildrenId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (4, 1, 1, 250000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');
INSERT INTO sales.order_products ("OrderId", "ProductChildrenId", "Quantity", "SinglePrice", "Status", "CreatedOn", "CreatedBy")
VALUES (4, 2, 2, 270000.00, 'ACT', CURRENT_TIMESTAMP, 'nppnam05@gmail.com');

