const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const Organization = require('./organization');
const User = require('./user');
const Template = require('./template');

const Article = sequelize.define('Article', {
  articleId: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  organizationId: {
    type: DataTypes.UUID,
    allowNull: false,
    references: {
      model: Organization,
      key: 'organizationId',
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
  title: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  body: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  summary: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  status: {
    type: DataTypes.ENUM('draft', 'in_review', 'approved', 'published', 'rejected'),
    defaultValue: 'draft',
  },
  category: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  tags: {
    type: DataTypes.JSON,
    allowNull: true,
  },
  createdAt: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  updatedAt: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  publishedAt: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  templateId: {
    type: DataTypes.UUID,
    allowNull: false,
    references: {
      model: Template,
      key: 'templateId',
    },
  },
}, {
  tableName: 'articles',
  timestamps: true,
  indexes: [{ fields: ['organizationId', 'status', 'publishedAt'] }],
});

Article.belongsTo(Organization, { foreignKey: 'organizationId' });
Article.belongsTo(User, { foreignKey: 'userId' });
Article.belongsTo(Template, { foreignKey: 'templateId' });
Organization.hasMany(Article, { foreignKey: 'organizationId' });
User.hasMany(Article, { foreignKey: 'userId' });
Template.hasMany(Article, { foreignKey: 'templateId' });

module.exports = Article;