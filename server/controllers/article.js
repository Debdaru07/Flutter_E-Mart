const Article = require('../models/article');

const createArticle = async (req, res) => {
  const { title, body, templateId } = req.body;
  const { userId, organizationId } = req.user;

  try {
    const article = await Article.create({
      organizationId,
      userId,
      title,
      body,
      templateId,
      status: 'draft',
    });
    res.status(201).json({ article });
  } catch (err) {
    res.status(500).json({ message: 'Failed to create article', error: err.message });
  }
};

module.exports = { createArticle };