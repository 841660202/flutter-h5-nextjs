import { PrismaClient as AuthSharePrismaClient } from '../prisma/generated/authShare';
import { PrismaClient as RecoverSharePrismaClient } from '../prisma/generated/recoverShare';
import { PrismaClient as BusinessPrismaClient } from '../prisma/generated/business';

const authSharePrisma = new AuthSharePrismaClient();
const recoverSharePrisma = new RecoverSharePrismaClient();
const businessPrisma = new BusinessPrismaClient();

export { authSharePrisma, recoverSharePrisma, businessPrisma };
