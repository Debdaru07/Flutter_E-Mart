const express = require('express');
const { schedulePublication } = require('../controllers/schedule');
const auth = require('../middleware/auth');
const { body } = require('express-validator');
const validate = require('../middleware/validate');

const router = express.Router();

router.post(
  '/schedules',
  auth,
  validate([
    body('articleId').isUUID().withMessage('Valid article ID required'),
    body('scheduledAt').isISO8601().withMessage('Valid date required'),
  ]),
  schedulePublication
);

module.exports = router;