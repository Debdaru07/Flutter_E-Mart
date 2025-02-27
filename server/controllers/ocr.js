const OCRResult = require('../models/ocrResult');

const getOCRResult = async (req, res) => {
  const { documentId } = req.params;

  try {
    const ocrResult = await OCRResult.findOne({ where: { documentId } });
    if (!ocrResult) return res.status(404).json({ message: 'OCR result not found' });
    res.json({ ocrResult });
  } catch (err) {
    res.status(500).json({ message: 'Failed to fetch OCR result', error: err.message });
  }
};

module.exports = { getOCRResult };