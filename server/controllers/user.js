const User = require('../models/user');
const bcrypt = require('bcryptjs');

const registerUser = async (req, res) => {
  const { email, password, role, firstName, lastName } = req.body;
  const { organizationId } = req.user; // From auth middleware

  try {
    const passwordHash = await bcrypt.hash(password, 10);
    const user = await User.create({
      organizationId,
      email,
      passwordHash,
      role,
      firstName,
      lastName,
    });
    res.status(201).json({ user });
  } catch (err) {
    res.status(500).json({ message: 'Failed to register user', error: err.message });
  }
};

module.exports = { registerUser };