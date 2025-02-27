const express = require('express');
const { createArticle } = require('../controllers/article');
const auth = require('../middleware/auth');
const { body } = require('express-validator');
const validate = require('../middleware/validate');

const router = express.Router();

router.post(
  '/articles',
  auth,
  validate([
    body('title').notEmpty(),
    body('body').notEmpty(),
    body('templateId').isUUID().withMessage('Valid template ID required'),
  ]),
  createArticle
);

module.exports = router;