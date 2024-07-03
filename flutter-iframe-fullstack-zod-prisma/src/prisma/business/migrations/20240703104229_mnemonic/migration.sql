/*
  Warnings:

  - Added the required column `mnemonic` to the `Private` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Private" ADD COLUMN     "mnemonic" TEXT NOT NULL;
