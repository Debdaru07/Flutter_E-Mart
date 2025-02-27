const PublicationSchedule = require('../models/publicationSchedule');

const schedulePublication = async (req, res) => {
  const { articleId, scheduledAt } = req.body;

  try {
    const schedule = await PublicationSchedule.create({
      articleId,
      scheduledAt,
      status: 'pending',
    });
    res.status(201).json({ schedule });
  } catch (err) {
    res.status(500).json({ message: 'Failed to schedule publication', error: err.message });
  }
};

module.exports = { schedulePublication };