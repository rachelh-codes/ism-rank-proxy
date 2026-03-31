FROM node:20-slim
# This new line creates a safe folder for your app
WORKDIR /app
RUN npm install express cors axios
COPY . .
RUN echo "const express = require('express'); \
const cors = require('cors'); \
const axios = require('axios'); \
const app = express(); \
app.use(cors()); \
app.use(express.json()); \
app.post('/api/check', async (req, res) => { \
  try { \
    const response = await axios.post('https://api.anthropic.com/v1/messages', req.body, { \
      headers: { \
        'x-api-key': process.env.ANTHROPIC_API_KEY, \
        'anthropic-version': '2023-06-01', \
        'content-type': 'application/json' \
      } \
    }); \
    res.json(response.data); \
  } catch (error) { \
    res.status(error.response?.status || 500).json(error.response?.data || error.message); \
  } \
}); \
app.listen(process.env.PORT || 3000);" > index.js
CMD ["node", "index.js"]
