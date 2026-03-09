enum DotsCaptureButtonType {
  photo,
  video;

  bool get isPhoto => this == DotsCaptureButtonType.photo;
  bool get isVideo => this == DotsCaptureButtonType.video;
}
