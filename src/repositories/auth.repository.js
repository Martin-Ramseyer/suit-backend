import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

export const findUserByUsername = async (username) => {
  return await prisma.usuario.findUnique({
    where: { username }
  })
}

export const createUser = async ({ username, password, nombre, rol }) => {
  return await prisma.usuario.create({
    data: {
      username,
      password,
      nombre,
      rol
    }
  })
}
