enum DotsCaptureButtonState {
  active,
  recording;

  bool get isActive => this == DotsCaptureButtonState.active;
  bool get isRecording => this == DotsCaptureButtonState.recording;
}
