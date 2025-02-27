const express = require('express');
const { submitReview } = require('../controllers/review');
const auth = require('../middleware/auth');
const { body } = require('express-validator');
const validate = require('../middleware/validate');

const router = express.Router();

router.post(
  '/reviews',
  auth,
  validate([
    body('articleId').isUUID().withMessage('Valid article ID required'),
    body('decision').isIn(['approved', 'rejected']).withMessage('Invalid decision'),
  ]),
  submitReview
);

module.exports = router;