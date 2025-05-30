enum DotsIconGroup {
  album('album'),
  arrow('arrow'),
  editingTools('editing_tools'),
  media('media'),
  premium('premium'),
  social('social'),
  system('system');

  const DotsIconGroup(this.folderName);
  final String folderName;
}

enum DotsIconData {
  // Album
  art('ic-art.svg', DotsIconGroup.album),
  book2('ic-book-2.svg', DotsIconGroup.album),
  cake('ic-cake.svg', DotsIconGroup.album),
  calendar('ic-calendar.svg', DotsIconGroup.album),
  calendarCheck('ic-calendar--check.svg', DotsIconGroup.album),
  calendarClock('ic-calendar--clock.svg', DotsIconGroup.album),
  calendarPartial('ic-calendar--partial.svg', DotsIconGroup.album),
  cameraGallery('ic-camera--gallery.svg', DotsIconGroup.album),
  child('ic-child.svg', DotsIconGroup.album),
  clockAlert('ic-clock--alert.svg', DotsIconGroup.album),
  clockNotification('ic-clock--notification.svg', DotsIconGroup.album),
  clockTimer('ic-clock--timer.svg', DotsIconGroup.album),
  clockFilled('ic-clock-filled.svg', DotsIconGroup.album),
  clockOutline('ic-clock-outline.svg', DotsIconGroup.album),
  couple('ic-couple.svg', DotsIconGroup.album),
  family('ic-family.svg', DotsIconGroup.album),
  fireworks('ic-fireworks.svg', DotsIconGroup.album),
  friends('ic-friends.svg', DotsIconGroup.album),
  heart('ic-heart.svg', DotsIconGroup.album),
  hiking('ic-hiking.svg', DotsIconGroup.album),
  laptop('ic-laptop.svg', DotsIconGroup.album),
  lecturer('ic-lecturer.svg', DotsIconGroup.album),
  locationPin('ic-location-pin.svg', DotsIconGroup.album),
  moon('ic-moon.svg', DotsIconGroup.album),
  music('ic-music.svg', DotsIconGroup.album),
  party('ic-party.svg', DotsIconGroup.album),
  paw('ic-paw.svg', DotsIconGroup.album),
  playPaperPlane('ic-play-paper-plane.svg', DotsIconGroup.album),
  puzzle('ic-puzzle.svg', DotsIconGroup.album),
  sportBasket('ic-sport--basket.svg', DotsIconGroup.album),
  sportFootball('ic-sport-football.svg', DotsIconGroup.album),
  weddingRings('ic-wedding-rings.svg', DotsIconGroup.album),
  work('ic-work.svg', DotsIconGroup.album),

  // Arrow
  blank('ic-_.svg', DotsIconGroup.arrow),
  diagonalUp('ic-arrow-diagonal-up.svg', DotsIconGroup.arrow),
  down('ic-arrow-down.svg', DotsIconGroup.arrow),
  right('ic-arrow-right.svg', DotsIconGroup.arrow),
  rightFilled('ic-arrow-right-filled.svg', DotsIconGroup.arrow),
  rightV2('ic-arrow-right-v2.svg', DotsIconGroup.arrow),
  up('ic-arrow-up.svg', DotsIconGroup.arrow),
  chevronDown('ic-chevron-down.svg', DotsIconGroup.arrow),
  chevronLeft('ic-chevron-left.svg', DotsIconGroup.arrow),
  chevronRight('ic-chevron-right.svg', DotsIconGroup.arrow),
  chevronUp('ic-chevron-up.svg', DotsIconGroup.arrow),
  download('ic-download.svg', DotsIconGroup.arrow),
  downloadCircle('ic-download-circle.svg', DotsIconGroup.arrow),
  exitFullscreen('ic-exit-fullscreen.svg', DotsIconGroup.arrow),
  fullscreen('ic-fullscreen.svg', DotsIconGroup.arrow),
  redo('ic-redo.svg', DotsIconGroup.arrow),
  refresh('ic-refresh.svg', DotsIconGroup.arrow),
  sort('ic-sort.svg', DotsIconGroup.arrow),
  upload('ic-upload.svg', DotsIconGroup.arrow),

  // Editing Tools
  add('ic-add.svg', DotsIconGroup.editingTools),
  addCircle('ic-add-circle.svg', DotsIconGroup.editingTools),
  addCircleOutline('ic-add-circle-outline.svg', DotsIconGroup.editingTools),
  copy('ic-copy.svg', DotsIconGroup.editingTools),
  crop('ic-crop.svg', DotsIconGroup.editingTools),
  draw('ic-draw.svg', DotsIconGroup.editingTools),
  drawNo('ic-draw-no.svg', DotsIconGroup.editingTools),
  edit('ic-edit.svg', DotsIconGroup.editingTools),
  editNotebook('ic-edit-notebook.svg', DotsIconGroup.editingTools),
  eye('ic-eye.svg', DotsIconGroup.editingTools),
  eyeOff('ic-eye--off.svg', DotsIconGroup.editingTools),
  lines('ic-lines.svg', DotsIconGroup.editingTools),
  list('ic-list.svg', DotsIconGroup.editingTools),
  lock('ic-lock.svg', DotsIconGroup.editingTools),
  order('ic-order.svg', DotsIconGroup.editingTools),
  pencil('ic-pencil.svg', DotsIconGroup.editingTools),
  print('ic-print.svg', DotsIconGroup.editingTools),
  remove('ic-remove.svg', DotsIconGroup.editingTools),
  rotateLeft('ic-rotate-left.svg', DotsIconGroup.editingTools),
  rotateRight('ic-rotate-right.svg', DotsIconGroup.editingTools),
  star('ic-star.svg', DotsIconGroup.editingTools),
  starOff('ic-star--off.svg', DotsIconGroup.editingTools),
  text('ic-text.svg', DotsIconGroup.editingTools),
  trash('ic-trash.svg', DotsIconGroup.editingTools),
  trashOpen('ic-trash-open.svg', DotsIconGroup.editingTools),

  // Media
  archive('ic-archive.svg', DotsIconGroup.media),
  book('ic-book.svg', DotsIconGroup.media),
  bookOpen('ic-book-open.svg', DotsIconGroup.media),
  bookOpenFilled('ic-book-open--filled.svg', DotsIconGroup.media),
  camera('ic-camera.svg', DotsIconGroup.media),
  cameraFrame('ic-camera--frame.svg', DotsIconGroup.media),
  cloud('ic-cloud.svg', DotsIconGroup.media),
  cloudCheck('ic-cloud-check.svg', DotsIconGroup.media),
  cloudV2('ic-cloud-v2.svg', DotsIconGroup.media),
  gallery('ic-gallery.svg', DotsIconGroup.media),
  galleryRefresh('ic-gallery--refresh.svg', DotsIconGroup.media),
  mic('ic-mic.svg', DotsIconGroup.media),
  pic('ic-pic.svg', DotsIconGroup.media),
  picDownload('ic-pic--download.svg', DotsIconGroup.media),
  picHeart('ic-pic--heart.svg', DotsIconGroup.media),
  picUpload('ic-pic--upload.svg', DotsIconGroup.media),
  pics('ic-pics.svg', DotsIconGroup.media),
  planner('ic-planner.svg', DotsIconGroup.media),
  template('ic-template.svg', DotsIconGroup.media),
  video('ic-video.svg', DotsIconGroup.media),
  videoOff('ic-video--off.svg', DotsIconGroup.media),

  // Premium
  creditCardAlert('ic-creditcard-alert.svg', DotsIconGroup.premium),
  gift('ic-gift.svg', DotsIconGroup.premium),
  level('ic-level.svg', DotsIconGroup.premium),
  level2('ic-level-2.svg', DotsIconGroup.premium),
  level3('ic-level-3.svg', DotsIconGroup.premium),
  level4('ic-level-4.svg', DotsIconGroup.premium),
  level5('ic-level-5.svg', DotsIconGroup.premium),
  level5Square('ic-level-5-square.svg', DotsIconGroup.premium),
  prime1('ic-prime-1.svg', DotsIconGroup.premium),
  prime2('ic-prime-2.svg', DotsIconGroup.premium),
  volumeOff('ic-volume--off.svg', DotsIconGroup.premium),

  // Social
  chat('ic-chat.svg', DotsIconGroup.social),
  chatLock('ic-chat-lock.svg', DotsIconGroup.social),
  fire('ic-fire.svg', DotsIconGroup.social),
  group('ic-group.svg', DotsIconGroup.social),
  link('ic-link.svg', DotsIconGroup.social),
  qr('ic-qr.svg', DotsIconGroup.social),
  qrScanV1('ic-qr-scan-v1.svg', DotsIconGroup.social),
  qrScanV2('ic-qr-scan-v2.svg', DotsIconGroup.social),
  send('ic-send.svg', DotsIconGroup.social),
  share('ic-share.svg', DotsIconGroup.social),
  shareAlt('ic-share-alt.svg', DotsIconGroup.social),
  user('ic-user.svg', DotsIconGroup.social),
  userFilled('ic-user--filled.svg', DotsIconGroup.social),
  userAddFilled('ic-user-add--filled.svg', DotsIconGroup.social),
  userAddOutlined('ic-user-add--outlined.svg', DotsIconGroup.social),
  userBlock('ic-user-block.svg', DotsIconGroup.social),
  userRemoveFilled('ic-user-remove--filled.svg', DotsIconGroup.social),
  userRemoveOutlined('ic-user-remove--outlined.svg', DotsIconGroup.social),

  // System
  alertCircle('ic-alert-circle.svg', DotsIconGroup.system),
  check('ic-check.svg', DotsIconGroup.system),
  checkCircle('ic-check-circle.svg', DotsIconGroup.system),
  checkCircleOutline('ic-check-circle-outline.svg', DotsIconGroup.system),
  cross('ic-cross.svg', DotsIconGroup.system),
  crossCircle('ic-cross-circle.svg', DotsIconGroup.system),
  darkMode('ic-dark-mode.svg', DotsIconGroup.system),
  filter('ic-filter.svg', DotsIconGroup.system),
  flag('ic-flag.svg', DotsIconGroup.system),
  globe('ic-globe.svg', DotsIconGroup.system),
  grid('ic-grid.svg', DotsIconGroup.system),
  hand('ic-hand.svg', DotsIconGroup.system),
  helpCircle('ic-help-circle.svg', DotsIconGroup.system),
  helpCircleOutline('ic-help-circle-outline.svg', DotsIconGroup.system),
  home('ic-home.svg', DotsIconGroup.system),
  infoCircle('ic-info-circle.svg', DotsIconGroup.system),
  lightbulb('ic-lightbulb.svg', DotsIconGroup.system),
  lightbulb2('ic-lightbulb-2.svg', DotsIconGroup.system),
  loading('ic-loading.svg', DotsIconGroup.system),
  notification('ic-notification.svg', DotsIconGroup.system),
  notificationOutlined('ic-notification--outlined.svg', DotsIconGroup.system),
  notificationOff('ic-notification-off.svg', DotsIconGroup.system),
  notificationOn('ic-notification-on.svg', DotsIconGroup.system),
  options('ic-options.svg', DotsIconGroup.system),
  radioOff('ic-radio--off.svg', DotsIconGroup.system),
  radioOn('ic-radio--on.svg', DotsIconGroup.system),
  search('ic-search.svg', DotsIconGroup.system),
  settings('ic-settings.svg', DotsIconGroup.system),
  selector('ic-selector.svg', DotsIconGroup.system);

  const DotsIconData(this.asset, this.iconGroup);
  final String asset;
  final DotsIconGroup iconGroup;
}
