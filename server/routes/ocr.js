const express = require('express');
const { getOCRResult } = require('../controllers/ocr');
const auth = require('../middleware/auth');

const router = express.Router();

router.get('/documents/:documentId/ocr', auth, getOCRResult);

module.exports = router;