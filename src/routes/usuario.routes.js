import express from 'express'
import { getUsuarios } from '../controllers/usuario.controller.js'

const router = express.Router()

router.get('/ListaUsuarios', getUsuarios)

export default router
