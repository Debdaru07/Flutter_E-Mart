const express = require('express');
const organizationRoutes = require('./organization');
const userRoutes = require('./user');
const articleRoutes = require('./article');
const reviewRoutes = require('./review');
const ocrRoutes = require('./ocr');
const scheduleRoutes = require('./schedule');

const router = express.Router();

router.use(organizationRoutes);
router.use(userRoutes);
router.use(articleRoutes);
router.use(reviewRoutes);
router.use(ocrRoutes);
router.use(scheduleRoutes);

module.exports = router;