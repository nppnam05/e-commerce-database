-- Ticket: EC-102
-- Description: create_cross_schema_foreign_keys
-- Schema: sales_to_inventories
-- Type: structure
-- Date: 2026-06-04
-- Author: nppna

-- =============================================================================
-- MIGRATION: create_cross_schema_foreign_keys
-- =============================================================================
-- Purpose: Add foreign key constraints from sales tables to inventories tables
--          after sample data has been populated.

ALTER TABLE sales.carts
    ADD CONSTRAINT "fk_cart_product" FOREIGN KEY ("ProductId") REFERENCES inventories.products("Id");

ALTER TABLE sales.order_products
    ADD CONSTRAINT "fk_order_product_product" FOREIGN KEY ("ProductId") REFERENCES inventories.products("Id");
