import { z } from 'zod';

export const share = z
  .object({
    userId: z.string(),
    publicKey: z.string(),
    authShare: z.string(),
    recoverShare: z.string(),
    mnemonic: z.string(),
  })
  .required();
