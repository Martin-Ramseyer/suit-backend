import jwt from 'jsonwebtoken'

const SECRET_KEY = process.env.SECRET_KEY

export const authenticateToken = (req, res, next) => {
  const token = req.cookies.token
  if (!token) {
    return res.sendStatus(401)
  }

  jwt.verify(token, SECRET_KEY, (err, user) => {
    if (err) {
      return res.sendStatus(403)
    }
    req.user = user
    next()
  })
}
