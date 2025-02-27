const Organization = require('../models/organization');

const registerOrganization = async (req, res) => {
  const { name, domain } = req.body;
  try {
    const organization = await Organization.create({ name, domain });
    res.status(201).json({ organization });
  } catch (err) {
    res.status(500).json({ message: 'Failed to register organization', error: err.message });
  }
};

module.exports = { registerOrganization };