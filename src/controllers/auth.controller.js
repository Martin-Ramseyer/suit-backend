import { loginUser, registerUser } from '../services/auth.service.js'

export const login = async (req, res) => {
  const { username, password } = req.body
  try {
    const token = await loginUser(username, password)
    res.cookie('token', token, { httpOnly: true })
    res.json({ message: 'Login exitoso' })
  } catch (error) {
    res.status(401).json({ message: 'Credenciales inválidas' })
  }
}

export const register = async (req, res) => {
  const { username, password, nombre, rol } = req.body
  try {
    await registerUser({ username, password, nombre, rol })
    res.status(201).json({ message: 'Usuario registrado exitosamente' })
  } catch (error) {
    res.status(400).json({ message: error.message })
  }
}
