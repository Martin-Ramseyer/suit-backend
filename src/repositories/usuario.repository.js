import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

export const findAllUsuarios = async () => {
  return await prisma.usuario.findMany()
}
