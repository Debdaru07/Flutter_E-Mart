const User = require('../models/user');
const bcrypt = require('bcryptjs');

const registerUser = async (req, res) => {
  console.log('here')
  const { organizationId, email, password, role, firstName, lastName } = req.body;
  console.log(req.body)
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
    console.log(err.message)
    res.status(500).json({ message: 'Failed to register user', error: err.message });
  }
};

module.exports = { registerUser };