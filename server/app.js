const express = require('express');
const dotenv = require('dotenv');
const routes = require('./routes/index');

dotenv.config();

const app = express();
app.use(express.json());

// Mount routes
app.use('/api', routes);

// Error handling (simplified)
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Something went wrong!' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});