const express = require('express');
const { registerUser } = require('../controllers/user');
const auth = require('../middleware/auth');
const { body } = require('express-validator');
const validate = require('../middleware/validate');

const router = express.Router();

router.post(
  '/users',
  // auth, // Only admins can register users
  validate([
    body('email').isEmail().withMessage('Valid email required'),
    body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 chars'),
    body('role').isIn(['journalist', 'editor', 'admin']).withMessage('Invalid role'),
    body('firstName').notEmpty(),
    body('lastName').notEmpty(),
  ]),
  registerUser
);

module.exports = router;