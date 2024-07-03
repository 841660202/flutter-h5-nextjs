```sh
# npx prisma generate --schema=src/prisma/authShare/schema.prisma
# npx prisma generate --schema=src/prisma/recoverShare/schema.prisma
# npx prisma generate --schema=src/prisma/business/schema.prisma


# npx prisma migrate dev  --schema=src/prisma/authShare/schema.prisma --name init
# npx prisma migrate dev  --schema=src/prisma/recoverShare/schema.prisma --name init
# npx prisma migrate dev  --schema=src/prisma/business/schema.prisma --name init


# npx prisma migrate dev  --schema=src/prisma/business/schema.prisma --name mnemonic
```

## zod example

```
http://localhost:3001/api/storePrivateKey?userId=1&publicKey=1&authShare=1&recoverShare=1&mnemonic=2

{
    "message": "hello",
    "data": [
        {
            "id": 2,
            "userId": "1",
            "authSalt": "1",
            "recoverSalt": "1"
        }
    ]
}
```

```
http://localhost:3001/api/storePrivateKey?userId=1&publicKey=1&authShare=1

{
    "error": "Validation error",
    "details": [
        {
            "path": [
                "recoverShare"
            ],
            "message": "Required"
        },
        {
            "path": [
                "mnemonic"
            ],
            "message": "Required"
        }
    ]
}
```
