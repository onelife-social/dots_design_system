enum DotsToastVariant {
  success,
  error,
  info,
  progress,
  connectionResumed,
  connectionLost,
  widget;

  bool get isProgress => this == DotsToastVariant.progress;
  bool get isWidget => this == DotsToastVariant.widget;
}
