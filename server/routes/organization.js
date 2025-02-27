const express = require('express');
const { registerOrganization } = require('../controllers/organization');
const { body } = require('express-validator');
const validate = require('../middleware/validate');

const router = express.Router();

router.post(
  '/organizations',
  validate([
    body('name').notEmpty().withMessage('Name is required'),
    body('domain').isString().withMessage('Domain must be a string'),
  ]),
  registerOrganization
);

module.exports = router;