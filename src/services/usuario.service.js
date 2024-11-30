import { findAllUsuarios } from '../repositories/usuario.repository.js'

export const getAllUsuarios = async () => {
  return await findAllUsuarios()
}
