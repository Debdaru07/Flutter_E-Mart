const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const Organization = require('./organization');
const User = require('./user');

const Document = sequelize.define('Document', {
  documentId: {
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
  filePath: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  status: {
    type: DataTypes.ENUM('uploaded', 'processing', 'completed', 'failed'),
    defaultValue: 'uploaded',
  },
  fileSize: {
    type: DataTypes.BIGINT,
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
}, {
  tableName: 'documents',
  timestamps: true,
  indexes: [{ fields: ['organizationId', 'status'] }],
});

Document.belongsTo(Organization, { foreignKey: 'organizationId' });
Document.belongsTo(User, { foreignKey: 'userId' });
Organization.hasMany(Document, { foreignKey: 'organizationId' });
User.hasMany(Document, { foreignKey: 'userId' });

module.exports = Document;