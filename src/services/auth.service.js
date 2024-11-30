import jwt from 'jsonwebtoken'
import bcrypt from 'bcrypt'
import { findUserByUsername, createUser } from '../repositories/auth.repository.js'

const SECRET_KEY = process.env.SECRET_KEY || 'default_secret_key'

export const loginUser = async (username, password) => {
  const user = await findUserByUsername(username)
  if (!user) {
    throw new Error('Usuario no encontrado')
  }

  const isPasswordValid = await bcrypt.compare(password, user.password)
  if (!isPasswordValid) {
    throw new Error('Contraseña incorrecta')
  }

  const token = jwt.sign({ id: user.id, rol: user.rol }, SECRET_KEY, { expiresIn: '1h' })
  return token
}

export const registerUser = async ({ username, password, nombre, rol }) => {
  const existingUser = await findUserByUsername(username)
  if (existingUser) {
    throw new Error('El nombre de usuario ya está en uso')
  }

  const hashedPassword = await bcrypt.hash(password, 10)
  await createUser({ username, password: hashedPassword, nombre, rol })
}
