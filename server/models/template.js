const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const Organization = require('./organization');

const Template = sequelize.define('Template', {
  templateId: {
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
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  structure: {
    type: DataTypes.JSON,
    allowNull: false,
  },
  isDefault: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
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
  tableName: 'templates',
  timestamps: true,
  indexes: [{ fields: ['organizationId'] }],
});

Template.belongsTo(Organization, { foreignKey: 'organizationId' });
Organization.hasMany(Template, { foreignKey: 'organizationId' });

module.exports = Template;