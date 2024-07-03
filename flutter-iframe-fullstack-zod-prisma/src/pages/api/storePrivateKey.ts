// pages/api/storePrivateKey.ts

import { NextApiRequest, NextApiResponse } from 'next';
import { authSharePrisma, recoverSharePrisma, businessPrisma } from '../../lib/prisma';
import { share } from '@/zod/share';
import { z } from 'zod';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'GET') {
    try {
      const { userId, publicKey, authShare, recoverShare, mnemonic } = share.parse(req.query);
      const user = await businessPrisma.user.findMany();
      res.status(200).json({ message: 'hello', data: user });
    } catch (error) {
      // Handle validation errors
      if (error instanceof z.ZodError) {
        return res.status(400).json({
          error: 'Validation error',
          details: error.errors.map((e) => ({
            path: e.path,
            message: e.message,
          })),
        });
      }
    }

    return;
  }
  if (req.method !== 'POST') {
    res.setHeader('Allow', ['POST']);
    res.status(405).end(`Method ${req.method} Not Allowed`);
    return;
  }

  const { userId, publicKey, authShare, recoverShare, mnemonic } = share.parse(req.body);

  try {
    // Step 1: Validate input
    if (!userId || !publicKey || !authShare || !recoverShare || !mnemonic) {
      res.status(400).json({ error: 'Missing required fields' });
      return;
    }

    // Step 2: Get user and validate
    const user = await businessPrisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      res.status(404).json({ error: 'User not found' });
      return;
    }

    // Step 3: Store authShare, recoverShare, private and wallet in a transaction
    await businessPrisma.$transaction(async (tx) => {
      const authShareRecord = await authSharePrisma.auth.create({
        data: { share: authShare },
      });

      const recoverShareRecord = await recoverSharePrisma.recover.create({
        data: { share: recoverShare },
      });

      const privateRecord = await tx.private.create({
        data: {
          authShareId: authShareRecord.id,
          recoverShareId: recoverShareRecord.id,
          mnemonic,
        },
      });

      await tx.wallet.create({
        data: {
          userId: userId,
          public: publicKey,
          privateId: privateRecord.id,
        },
      });
    });

    res.status(200).json({ message: 'Private key stored successfully' });
  } catch (error) {
    console.error('Error storing private key:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  } finally {
    await businessPrisma.$disconnect();
    await authSharePrisma.$disconnect();
    await recoverSharePrisma.$disconnect();
  }
}
