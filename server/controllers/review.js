const Review = require('../models/review');
const Article = require('../models/article');

const submitReview = async (req, res) => {
  const { articleId, decision, comment } = req.body;
  const { userId } = req.user;

  try {
    const review = await Review.create({ articleId, userId, decision, comment });
    await Article.update({ status: decision }, { where: { articleId } });
    res.status(201).json({ review });
  } catch (err) {
    res.status(500).json({ message: 'Failed to submit review', error: err.message });
  }
};

module.exports = { submitReview };