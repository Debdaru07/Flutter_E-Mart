const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const Article = require('./article');

const PublicationSchedule = sequelize.define('PublicationSchedule', {
  scheduleId: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  articleId: {
    type: DataTypes.UUID,
    allowNull: false,
    unique: true,
    references: {
      model: Article,
      key: 'articleId',
    },
  },
  scheduledAt: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  status: {
    type: DataTypes.ENUM('pending', 'completed', 'failed'),
    defaultValue: 'pending',
  },
  createdAt: {
    type: DataTypes.DATE,
    allowNull: false,
  },
}, {
  tableName: 'publication_schedules',
  timestamps: true,
  updatedAt: false,
  indexes: [{ fields: ['scheduledAt', 'status'] }],
});

PublicationSchedule.belongsTo(Article, { foreignKey: 'articleId' });
Article.hasOne(PublicationSchedule, { foreignKey: 'articleId' });

module.exports = PublicationSchedule;