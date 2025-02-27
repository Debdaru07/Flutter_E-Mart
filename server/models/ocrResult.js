const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const Document = require('./document');

const OCRResult = sequelize.define('OCRResult', {
  ocrResultId: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  documentId: {
    type: DataTypes.UUID,
    allowNull: false,
    unique: true,
    references: {
      model: Document,
      key: 'documentId',
    },
  },
  extractedText: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  extractedImages: {
    type: DataTypes.JSON,
    allowNull: true,
  },
  confidenceScore: {
    type: DataTypes.FLOAT,
    allowNull: true,
  },
  processedAt: {
    type: DataTypes.DATE,
    allowNull: false,
  },
}, {
  tableName: 'ocr_results',
  timestamps: false,
  indexes: [{ fields: ['documentId'] }],
});

OCRResult.belongsTo(Document, { foreignKey: 'documentId' });
Document.hasOne(OCRResult, { foreignKey: 'documentId' });

module.exports = OCRResult;