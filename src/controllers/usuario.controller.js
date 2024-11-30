import { getAllUsuarios } from '../services/usuario.service.js'

export const getUsuarios = async (req, res) => {
  try {
    const usuarios = await getAllUsuarios()
    res.json(usuarios)
  } catch (error) {
    res.status(500).json({ message: 'Error en el servidor' })
  }
}
