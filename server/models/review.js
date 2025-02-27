const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const Article = require('./article');
const User = require('./user');

const Review = sequelize.define('Review', {
  reviewId: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  articleId: {
    type: DataTypes.UUID,
    allowNull: false,
    references: {
      model: Article,
      key: 'articleId',
    },
  },
  userId: {
    type: DataTypes.UUID,
    allowNull: false,
    references: {
      model: User,
      key: 'userId',
    },
  },
  comment: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  decision: {
    type: DataTypes.ENUM('approved', 'rejected'),
    allowNull: false,
  },
  reviewedAt: {
    type: DataTypes.DATE,
    allowNull: false,
  },
}, {
  tableName: 'reviews',
  timestamps: false,
  indexes: [{ fields: ['articleId'] }],
});

Review.belongsTo(Article, { foreignKey: 'articleId' });
Review.belongsTo(User, { foreignKey: 'userId' });
Article.hasMany(Review, { foreignKey: 'articleId' });
User.hasMany(Review, { foreignKey: 'userId' });

module.exports = Review;