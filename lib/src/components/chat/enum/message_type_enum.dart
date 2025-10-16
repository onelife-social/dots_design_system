enum MessageType {
  text,
  image,
  video,
  audio,
  file;

  bool get isAttachment => this != MessageType.text;
  bool get isText => this == MessageType.text;
}
