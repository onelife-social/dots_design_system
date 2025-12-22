enum UploadItemVariant {
  processing,
  success,
  error;

  bool get isProcessing => this == UploadItemVariant.processing;
  bool get isSuccess => this == UploadItemVariant.success;
  bool get isError => this == UploadItemVariant.error;
}
