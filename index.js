import 'dotenv/config'
import { PORT } from './config.js'
import express from 'express'
import cookieParser from 'cookie-parser'
import authRoutes from './src/routes/auth.routes.js'

const app = express()
app.use(express.json())
app.use(cookieParser())

app.use('/auth', authRoutes)

app.get('/', (req, res) => {
  res.send('Hello World')
})

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`)
})
