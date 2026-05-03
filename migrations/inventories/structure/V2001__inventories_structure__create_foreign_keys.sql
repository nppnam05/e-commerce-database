-- Ticket: EC-102
-- Description: create_foreign_keys
-- Schema: all (placed in inventories for execution order)
-- Type: structure
-- Date: 2026-05-03
-- Author: nppna

-- =============================================================================
-- MIGRATION: create_foreign_keys
-- =============================================================================
-- Purpose: Add foreign key constraints across all schemas

-- =============================================================================
-- IDENTITY SCHEMA FOREIGN KEYS
-- =============================================================================
ALTER TABLE identity.user_session
    ADD CONSTRAINT "fk_user_session_user" FOREIGN KEY ("UserId") REFERENCES identity.users("Id");

-- =============================================================================
-- INVENTORIES SCHEMA FOREIGN KEYS
-- =============================================================================
ALTER TABLE inventories.products
    ADD CONSTRAINT "fk_product_category" FOREIGN KEY ("CategoryId") REFERENCES inventories.categories("Id"),
    ADD CONSTRAINT "fk_product_color" FOREIGN KEY ("ColorId") REFERENCES inventories.colors("Id"),
    ADD CONSTRAINT "fk_product_size" FOREIGN KEY ("SizeId") REFERENCES inventories.sizes("Id");

ALTER TABLE inventories.product_images
    ADD CONSTRAINT "fk_product_image_product" FOREIGN KEY ("productId") REFERENCES inventories.products("Id");

ALTER TABLE inventories.stocks
    ADD CONSTRAINT "fk_stock_product" FOREIGN KEY ("ProductId") REFERENCES inventories.products("Id");

-- =============================================================================
-- SALES SCHEMA FOREIGN KEYS
-- =============================================================================
ALTER TABLE sales.carts
    ADD CONSTRAINT "fk_cart_user" FOREIGN KEY ("UserId") REFERENCES identity.users("Id"),
    ADD CONSTRAINT "fk_cart_product" FOREIGN KEY ("ProductId") REFERENCES inventories.products("Id");

ALTER TABLE sales.orders
    ADD CONSTRAINT "fk_order_user" FOREIGN KEY ("UserId") REFERENCES identity.users("Id");

ALTER TABLE sales.order_products
    ADD CONSTRAINT "fk_order_product_order" FOREIGN KEY ("OrderId") REFERENCES sales.orders("Id"),
    ADD CONSTRAINT "fk_order_product_product" FOREIGN KEY ("ProductId") REFERENCES inventories.products("Id");
