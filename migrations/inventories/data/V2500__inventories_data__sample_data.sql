-- Ticket: 1
-- Description: sample_data
-- Schema: inventories
-- Type: data
-- Date: ~0,4-~4,2-~6,2
-- Author: nppna

-- =============================================================================
-- MIGRATION: sample_data
-- =============================================================================
-- Purpose: [Detailed explanation of why this change is needed]
--
-- Impact:
--   - Tables affected: inventories.[table_name]
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
-- INSERT INTO inventories.table_name ("Id", "Name", "Code", "Status")
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
--         WHERE table_schema = 'inventories'
--         AND table_name = 'table_name'
--         AND column_name = 'ColumnName'
--     ) THEN
--         RAISE EXCEPTION 'Migration failed: Column not created';
--     END IF;
--
--     RAISE NOTICE 'Migration completed successfully';
-- END $$;

-- 1. DỮ LIỆU MẪU CHO BẢNG CATEGORIES (DANH MỤC)
INSERT INTO inventories.categories ("Name", "Description", "Status", "CreatedOn", "CreatedBy") VALUES
('Áo Nam', 'Các loại áo thời trang dành cho nam giới', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
('Quần Nam', 'Các loại quần thời trang dành cho nam giới', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
('Giày Thể Thao', 'Giày thể thao năng động, chạy bộ, tập gym', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
('Phụ Kiện', 'Bao gồm bóp ví, thắt lưng, nón', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM');

-- 2. DỮ LIỆU MẪU CHO BẢNG COLORS (MÀU SẮC)
INSERT INTO inventories.colors ("Name", "ColorCode", "Status", "CreatedOn", "CreatedBy") VALUES
('Đen', '#000000', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
('Trắng', '#FFFFFF', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
('Xanh Dương', '#0000FF', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
('Xám', '#808080', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM');

-- 3. DỮ LIỆU MẪU CHO BẢNG SIZES (KÍCH CỠ)
INSERT INTO inventories.sizes ("Name", "Description", "Status", "CreatedOn", "CreatedBy") VALUES
('S', 'Size Nhỏ (Small)', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
('M', 'Size Vừa (Medium)', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
('L', 'Size Lớn (Large)', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
('XL', 'Size Rất Lớn (Extra Large)', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
('39', 'Kích cỡ giày 39', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
('40', 'Kích cỡ giày 40', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM');

-- 1. BỔ SUNG 15 SẢN PHẨM MẪU VÀO BẢNG PRODUCTS
INSERT INTO inventories.products ("CategoryId", "ColorId", "SizeId", "Price", "Name", "Description", "Status", "CreatedOn", "CreatedBy") VALUES
(1, 1, 2, 250000.00, 'Áo Thun Polo Classic M', 'Áo thun polo nam chất liệu cotton thoáng mát, màu đen size M', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(1, 2, 3, 270000.00, 'Áo Thun Polo Classic L', 'Áo thun polo nam chất liệu cotton thoáng mát, màu trắng size L', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(1, 3, 2, 290000.00, 'Áo Thun Thể Thao Xanh M', 'Áo thun chất liệu mát, thấm hút mồ hôi tốt', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'), 
(1, 1, 4, 350000.00, 'Áo Sơ Mi Công Sở XL', 'Áo sơ mi dài tay màu đen lịch lãm, chất vải ít nhăn', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'), 
(1, 4, 2, 550000.00, 'Áo Khoác Bomber Xám M', 'Áo khoác bomber 2 lớp dày dặn, giữ ấm tốt', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),

(2, 1, 3, 450000.00, 'Quần Jean Slimfit Đen L', 'Quần jean nam dáng ôm vừa vặn, co giãn tốt', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'), 
(2, 4, 4, 380000.00, 'Quần Kaki Công Sở XL', 'Quần kaki dáng đứng thanh lịch cho nam', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'), 
(2, 4, 2, 390000.00, 'Quần Tây Ống Đứng Xám M', 'Quần tây chất liệu cao cấp, co giãn nhẹ, phù hợp đi làm', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(2, 1, 3, 220000.00, 'Quần Short Thể Thao Đen L', 'Quần short nam mặc nhà hoặc tập thể thao thoải mái', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'), 
(2, 3, 4, 420000.00, 'Quần Kaki Túi Hộp Xanh XL', 'Quần kaki túi hộp phong cách cá tính, bụi bặm', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),

(3, 2, 5, 1200000.00, 'Giày Chạy Bộ Ultra 39', 'Giày thể thao siêu nhẹ, đệm êm ái', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'), 
(3, 1, 6, 1500000.00, 'Giày Sneaker Đen 40', 'Giày chạy bộ chuyên dụng, đế cao su chống trượt tốt', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),

(4, 1, 1, 150000.00, 'Ví Da Nam Cầm Tay', 'Ví da bò thật dáng ngang nhỏ gọn', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'), 
(4, 1, 1, 280000.00, 'Thắt Lưng Da Nam Khóa Tự Động', 'Thắt lưng da cao cấp, mặt khóa kim loại chống rỉ', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'), 
(4, 4, 1, 190000.00, 'Nón Lưỡi Trai Xám', 'Nón kết chất vải canvas dày dặn, dễ phối đồ', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM');


-- 2. BỔ SUNG HÌNH ẢNH TƯƠNG ỨNG VÀO BẢNG PRODUCT_IMAGES
INSERT INTO inventories.product_images ("productId", "url", "Status", "CreatedOn", "CreatedBy") VALUES
 (1, 'http://223.130.11.143:9000/e-commerce/a002626d-2f0b-4217-91dd-f3ee09a50520_Screenshot 2026-06-06 135657.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (2, 'http://223.130.11.143:9000/e-commerce/ea8f21ea-dac5-4082-8ae1-ec653a8dae7a_Screenshot 2026-06-06 135816.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (3, 'http://223.130.11.143:9000/e-commerce/ab97aed5-5056-423a-bdae-a956480c374b_Screenshot 2026-06-06 135922.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (4, 'http://223.130.11.143:9000/e-commerce/92ac3e5b-ece7-4a1e-83f0-e531a3dde55e_Screenshot 2026-06-06 140017.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (5, 'http://223.130.11.143:9000/e-commerce/d24025d4-c2de-4898-800e-dd5206ca9390_Screenshot 2026-06-06 140109.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (6, 'http://223.130.11.143:9000/e-commerce/7e057637-1619-4697-a393-53535ae682ca_Screenshot 2026-06-06 140154.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (7, 'http://223.130.11.143:9000/e-commerce/56182e45-cd7a-4e40-a497-fbc7b1cdbb0b_Screenshot 2026-06-06 140242.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (8, 'http://223.130.11.143:9000/e-commerce/32712579-bec5-483b-a504-4b50e7eee1fc_Screenshot 2026-06-06 140416.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (9, 'http://223.130.11.143:9000/e-commerce/963c65a2-319a-4f01-bffa-b637ac137fac_Screenshot 2026-06-06 140507.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (10, 'http://223.130.11.143:9000/e-commerce/a372769f-3ff2-4a1e-a243-06396a7a47f7_Screenshot 2026-06-06 140608.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (11, 'http://223.130.11.143:9000/e-commerce/a2fe6902-76f9-4baa-9fd9-2d343b9874ca_Screenshot 2026-06-06 140706.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (12, 'http://223.130.11.143:9000/e-commerce/69de4aa2-c45e-4b49-853c-70920bc9098a_Screenshot 2026-06-06 140757.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (13, 'http://223.130.11.143:9000/e-commerce/df76d7fd-2f7f-431f-b22e-73f5255c7f84_Screenshot 2026-06-06 140834.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (14, 'http://223.130.11.143:9000/e-commerce/7bf50810-4e74-4376-b655-78c57bb5ae6d_Screenshot 2026-06-06 140919.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
 (15, 'http://223.130.11.143:9000/e-commerce/7a9e92c7-54d6-431b-b704-6161f9f0e70e_Screenshot 2026-06-06 141010.png', 'ACT', CURRENT_TIMESTAMP, 'SYSTEM');


-- 6. DỮ LIỆU MẪU CHO BẢNG STOCKS (KHO HÀNG)
INSERT INTO inventories.stocks ("ProductId", "Quantity", "Status", "CreatedOn", "CreatedBy") VALUES
(1, 50, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(2, 35, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(3, 20, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(4, 15, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(5, 10, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(6, 100, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM');

-- 7. FAVOURITES
INSERT INTO inventories.favourites ("UserId", "ProductId", "Status", "CreatedOn", "CreatedBy") VALUES
(2, 1, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(2, 2, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(2, 3, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(2, 4, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(2, 5, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(2, 6, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(2, 7, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(2, 8, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(2, 9, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM'),
(2, 10, 'ACT', CURRENT_TIMESTAMP, 'SYSTEM');