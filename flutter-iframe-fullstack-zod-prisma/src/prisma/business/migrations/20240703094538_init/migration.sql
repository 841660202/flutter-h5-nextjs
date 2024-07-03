-- CreateTable
CREATE TABLE "App" (
    "id" SERIAL NOT NULL,
    "appId" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "App_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Domain" (
    "id" SERIAL NOT NULL,
    "domain" TEXT NOT NULL,
    "appId" INTEGER NOT NULL,

    CONSTRAINT "Domain_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "authSalt" TEXT NOT NULL,
    "recoverSalt" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Wallet" (
    "id" SERIAL NOT NULL,
    "public" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "privateId" INTEGER,

    CONSTRAINT "Wallet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Private" (
    "id" SERIAL NOT NULL,
    "authShareId" INTEGER NOT NULL,
    "recoverShareId" INTEGER NOT NULL,

    CONSTRAINT "Private_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Domain" ADD CONSTRAINT "Domain_appId_fkey" FOREIGN KEY ("appId") REFERENCES "App"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Wallet" ADD CONSTRAINT "Wallet_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Wallet" ADD CONSTRAINT "Wallet_privateId_fkey" FOREIGN KEY ("privateId") REFERENCES "Private"("id") ON DELETE SET NULL ON UPDATE CASCADE;
