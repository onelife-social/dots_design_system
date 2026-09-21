// @dots/design-system — public surface. One export line per component.
// Every bundle component is ported to TSX; ../tool/design_sync/_src is empty. A new Dart widget gets
// its TSX port here (see README) — never a legacy _src implementation.
export { DotsIcon, dotsIconNames } from './components/DotsIcon/DotsIcon';
export type { DotsIconProps, DotsIconName } from './components/DotsIcon/DotsIcon';
export { DotsSpinner } from './components/DotsSpinner/DotsSpinner';
export type { DotsSpinnerProps } from './components/DotsSpinner/DotsSpinner';
export { DotsMainButton } from './components/DotsMainButton/DotsMainButton';
export type {
  DotsMainButtonProps,
  DotsMainButtonSize,
  DotsMainButtonVariant,
} from './components/DotsMainButton/DotsMainButton';
export { DotsMainContainer } from './components/DotsMainContainer/DotsMainContainer';
export type { DotsMainContainerProps, DotsMainContainerVariant } from './components/DotsMainContainer/DotsMainContainer';
export { DotsIconButton } from './components/DotsIconButton/DotsIconButton';
export type { DotsIconButtonProps, DotsIconButtonSize, DotsIconButtonStyle, DotsIconButtonState } from './components/DotsIconButton/DotsIconButton';
export { DotsProgressBar } from './components/DotsProgressBar/DotsProgressBar';
export type { DotsProgressBarProps } from './components/DotsProgressBar/DotsProgressBar';
export { DotsProfilePhoto } from './components/DotsProfilePhoto/DotsProfilePhoto';
export type { DotsProfilePhotoProps } from './components/DotsProfilePhoto/DotsProfilePhoto';
export { PageControl } from './components/PageControl/PageControl';
export type { PageControlProps } from './components/PageControl/PageControl';
export { DotsTextField } from './components/DotsTextField/DotsTextField';
export type { DotsTextFieldProps } from './components/DotsTextField/DotsTextField';
export { DotsTextFieldDate } from './components/DotsTextFieldDate/DotsTextFieldDate';
export type { DotsTextFieldDateProps } from './components/DotsTextFieldDate/DotsTextFieldDate';
export { EventGroupCard } from './components/EventGroupCard/EventGroupCard';
export type { EventGroupCardProps, EventGroupCardAction, EventGroupCardVariant } from './components/EventGroupCard/EventGroupCard';
export { DotsRadioButton } from './components/DotsRadioButton/DotsRadioButton';
export type { DotsRadioButtonProps } from './components/DotsRadioButton/DotsRadioButton';
export { DotsToggle } from './components/DotsToggle/DotsToggle';
export type { DotsToggleProps } from './components/DotsToggle/DotsToggle';
export { DotsRichButton } from './components/DotsRichButton/DotsRichButton';
export type { DotsRichButtonProps } from './components/DotsRichButton/DotsRichButton';
export { DotsActionSheet, DotsActionSheetListItem } from './components/DotsActionSheet/DotsActionSheet';
export type {
  DotsActionSheetProps,
  DotsActionSheetVariant,
  DotsActionSheetListItemProps,
  DotsActionSheetRadioOption,
  DotsActionSheetSelectedItem,
  DotsActionSheetSystemButton,
} from './components/DotsActionSheet/DotsActionSheet';
export { DotsTopBar } from './components/DotsTopBar/DotsTopBar';
export type { DotsTopBarProps, DotsTopBarVariant } from './components/DotsTopBar/DotsTopBar';
export { DotsAlert } from './components/DotsAlert/DotsAlert';
export type { DotsAlertProps, DotsAlertVariant, DotsAlertSelectorItem } from './components/DotsAlert/DotsAlert';
export { DotsCalendar } from './components/DotsCalendar/DotsCalendar';
export type { DotsCalendarProps } from './components/DotsCalendar/DotsCalendar';
export { DotsCloseButton } from './components/DotsCloseButton/DotsCloseButton';
export type { DotsCloseButtonProps, DotsCloseButtonSize, DotsCloseButtonVariant } from './components/DotsCloseButton/DotsCloseButton';
export { DotsTextFieldButton } from './components/DotsTextFieldButton/DotsTextFieldButton';
export type { DotsTextFieldButtonProps } from './components/DotsTextFieldButton/DotsTextFieldButton';
export { DotsSelector } from './components/DotsSelector/DotsSelector';
export type { DotsSelectorProps, DotsSelectorSize, DotsSelectorVariant } from './components/DotsSelector/DotsSelector';
export { DotsSystemButton } from './components/DotsSystemButton/DotsSystemButton';
export type { DotsSystemButtonProps, DotsSystemButtonSize, DotsSystemButtonVariant } from './components/DotsSystemButton/DotsSystemButton';
export { DotsFloatingButton } from './components/DotsFloatingButton/DotsFloatingButton';
export type { DotsFloatingButtonProps } from './components/DotsFloatingButton/DotsFloatingButton';
export { DotsCaptureButton } from './components/DotsCaptureButton/DotsCaptureButton';
export type { DotsCaptureButtonProps, DotsCaptureButtonType, DotsCaptureButtonState } from './components/DotsCaptureButton/DotsCaptureButton';
export { DotsInputStepper } from './components/DotsInputStepper/DotsInputStepper';
export type { DotsInputStepperProps } from './components/DotsInputStepper/DotsInputStepper';
export { BtnFolder } from './components/BtnFolder/BtnFolder';
export type { BtnFolderProps } from './components/BtnFolder/BtnFolder';
export { FolderCarrousel } from './components/FolderCarrousel/FolderCarrousel';
export type { FolderCarrouselProps, FolderCarrouselItem } from './components/FolderCarrousel/FolderCarrousel';
export { DotsCountdown } from './components/DotsCountdown/DotsCountdown';
export type { DotsCountdownProps, DotsCountdownVariant } from './components/DotsCountdown/DotsCountdown';
export { ImageThumbnail } from './components/ImageThumbnail/ImageThumbnail';
export type { ImageThumbnailProps, ImageThumbnailVariant } from './components/ImageThumbnail/ImageThumbnail';
export { ImageWithProgressAround } from './components/ImageWithProgressAround/ImageWithProgressAround';
export type { ImageWithProgressAroundProps, ImageWithProgressAroundAspectRatio } from './components/ImageWithProgressAround/ImageWithProgressAround';
export { DotsItemInput } from './components/DotsItemInput/DotsItemInput';
export type { DotsItemInputProps, DotsItemInputPosition } from './components/DotsItemInput/DotsItemInput';
export { DotsSegmentedControl } from './components/DotsSegmentedControl/DotsSegmentedControl';
export type { DotsSegmentedControlProps, DotsSegmentedControlOption, DotsSegmentedControlType, DotsSegmentedControlVariant } from './components/DotsSegmentedControl/DotsSegmentedControl';
export { DotsTextArea } from './components/DotsTextArea/DotsTextArea';
export type { DotsTextAreaProps } from './components/DotsTextArea/DotsTextArea';
export { DotsTextFieldPhone } from './components/DotsTextFieldPhone/DotsTextFieldPhone';
export type { DotsTextFieldPhoneProps, PhoneCountryCode } from './components/DotsTextFieldPhone/DotsTextFieldPhone';
export { DotsDivider } from './components/DotsDivider/DotsDivider';
export type { DotsDividerProps } from './components/DotsDivider/DotsDivider';
export { DotsAccordion } from './components/DotsAccordion/DotsAccordion';
export type { DotsAccordionProps, DotsAccordionSection } from './components/DotsAccordion/DotsAccordion';
export { DotsSlider } from './components/DotsSlider/DotsSlider';
export type { DotsSliderProps } from './components/DotsSlider/DotsSlider';
export { ColorSelector } from './components/ColorSelector/ColorSelector';
export type { ColorSelectorProps, ColorSelectorVariant, DotsColorOption } from './components/ColorSelector/ColorSelector';
export { BlurContainer, GradientBlur } from './components/BlurContainer/BlurContainer';
export type { BlurContainerProps, GradientBlurProps, BlurAlignment } from './components/BlurContainer/BlurContainer';
export { DotsBottomEdgeBlur } from './components/DotsBottomEdgeBlur/DotsBottomEdgeBlur';
export type { DotsBottomEdgeBlurProps } from './components/DotsBottomEdgeBlur/DotsBottomEdgeBlur';
export { FeatureItem } from './components/FeatureItem/FeatureItem';
export type { FeatureItemProps } from './components/FeatureItem/FeatureItem';
export { RatingRow } from './components/RatingRow/RatingRow';
export type { RatingRowProps, RatingStarVariant } from './components/RatingRow/RatingRow';
export { DotsEmptyStateCard } from './components/DotsEmptyStateCard/DotsEmptyStateCard';
export type { DotsEmptyStateCardProps, DotsEmptyStateCardVariant } from './components/DotsEmptyStateCard/DotsEmptyStateCard';
export { DotsFilterChip } from './components/DotsFilterChip/DotsFilterChip';
export type { DotsFilterChipProps } from './components/DotsFilterChip/DotsFilterChip';
export { DotsToast } from './components/DotsToast/DotsToast';
export type { DotsToastProps, DotsToastVariant } from './components/DotsToast/DotsToast';
export { DotsMenu, DotsMenuSettingsList, DotsMenuSettingsItem } from './components/DotsMenu/DotsMenu';
export type {
  DotsMenuProps,
  DotsMenuItemModel,
  DotsMenuSettingsListProps,
  DotsMenuSettingsItemProps,
  DotsMenuSettingsItemVariant,
} from './components/DotsMenu/DotsMenu';
export { DotsTooltip } from './components/DotsTooltip/DotsTooltip';
export type { DotsTooltipProps, DotsToolTipTailPosition } from './components/DotsTooltip/DotsTooltip';
export { DropdownMenu, DropdownMenuItem } from './components/DropdownMenu/DropdownMenu';
export type { DropdownMenuProps, DropdownMenuItemProps, DropdownMenuSize, DropdownMenuVariant } from './components/DropdownMenu/DropdownMenu';
export { DotsListItem } from './components/DotsListItem/DotsListItem';
export type { DotsListItemProps, DotsListItemVariant, DotsListItemPicType } from './components/DotsListItem/DotsListItem';
export { DotsHomeTopBar } from './components/DotsHomeTopBar/DotsHomeTopBar';
export type { DotsHomeTopBarProps, DotsHomeTopBarVariant } from './components/DotsHomeTopBar/DotsHomeTopBar';
export { DotsNavBar } from './components/DotsNavBar/DotsNavBar';
export type { DotsNavBarProps, DotsNavBarItem } from './components/DotsNavBar/DotsNavBar';
export { DotsSquirclePhoto, DotsSquirclePhotoTag } from './components/DotsSquirclePhoto/DotsSquirclePhoto';
export type { DotsSquirclePhotoProps, DotsSquirclePhotoTagProps } from './components/DotsSquirclePhoto/DotsSquirclePhoto';
export { DotsUploadItem } from './components/DotsUploadItem/DotsUploadItem';
export type { DotsUploadItemProps, DotsUploadItemVariant } from './components/DotsUploadItem/DotsUploadItem';
export { AlbumGroupCard } from './components/AlbumGroupCard/AlbumGroupCard';
export type { AlbumGroupCardProps, AlbumGroupCardVariant } from './components/AlbumGroupCard/AlbumGroupCard';
export { CreateCard } from './components/CreateCard/CreateCard';
export type { CreateCardProps, CreateCardVariant } from './components/CreateCard/CreateCard';
export { MemoryCard } from './components/MemoryCard/MemoryCard';
export type { MemoryCardProps, MemoryCardVariant } from './components/MemoryCard/MemoryCard';
export { ProductCard } from './components/ProductCard/ProductCard';
export type { ProductCardProps } from './components/ProductCard/ProductCard';
export { UserItem, UserInfo } from './components/UserItem/UserItem';
export type { UserItemProps, UserInfoProps, UserInfoSize } from './components/UserItem/UserItem';
export { UsersList, UsersListItem } from './components/UsersList/UsersList';
export type {
  UsersListProps,
  UsersListItemProps,
  UsersListItemVariant,
  UsersListMember,
  UsersListMemberType,
} from './components/UsersList/UsersList';
export { ActivityPreview, ActivityOverviewItem } from './components/ActivityPreview/ActivityPreview';
export type { ActivityPreviewProps, ActivityOverviewItemProps, ActivityPreviewVariant } from './components/ActivityPreview/ActivityPreview';
export { ImageWithIcon } from './components/ImageWithIcon/ImageWithIcon';
export type { ImageWithIconProps } from './components/ImageWithIcon/ImageWithIcon';
export { MessagePreview } from './components/MessagePreview/MessagePreview';
export type { MessagePreviewProps, MessagePreviewAttachmentType } from './components/MessagePreview/MessagePreview';
export { NotificationBanner } from './components/NotificationBanner/NotificationBanner';
export type { NotificationBannerProps } from './components/NotificationBanner/NotificationBanner';
export { NotificationBannerImage } from './components/NotificationBannerImage/NotificationBannerImage';
export type { NotificationBannerImageProps } from './components/NotificationBannerImage/NotificationBannerImage';
export { BadgeIcon } from './components/BadgeIcon/BadgeIcon';
export type { BadgeIconProps, BadgeIconSize, BadgeIconStyle } from './components/BadgeIcon/BadgeIcon';
export { BadgeLabel } from './components/BadgeLabel/BadgeLabel';
export type { BadgeLabelProps, BadgeLabelSize, BadgeLabelVariant } from './components/BadgeLabel/BadgeLabel';
export { BadgeMilestone } from './components/BadgeMilestone/BadgeMilestone';
export type { BadgeMilestoneProps, BadgeMilestoneVariant } from './components/BadgeMilestone/BadgeMilestone';
export { BadgeProgress } from './components/BadgeProgress/BadgeProgress';
export type { BadgeProgressProps } from './components/BadgeProgress/BadgeProgress';
export { BadgeTag } from './components/BadgeTag/BadgeTag';
export type { BadgeTagProps } from './components/BadgeTag/BadgeTag';
export { DotsSelectorRadioButton, DotsSelectorRadioButtonLabel, DotsSettingItemRadioBtn } from './components/DotsSelectorRadioButton/DotsSelectorRadioButton';
export type { DotsSelectorRadioButtonProps, DotsSelectorRadioButtonLabelProps, DotsSettingItemRadioBtnProps, SelectorRadioButtonLabelVariant } from './components/DotsSelectorRadioButton/DotsSelectorRadioButton';
export { MilestoneCard } from './components/MilestoneCard/MilestoneCard';
export type { MilestoneCardProps, MilestoneBadgeType } from './components/MilestoneCard/MilestoneCard';
export { MilestonesList } from './components/MilestonesList/MilestonesList';
export type { MilestonesListProps, MilestonesListItem } from './components/MilestonesList/MilestonesList';
export { RecapCard } from './components/RecapCard/RecapCard';
export type { RecapCardProps, RecapCardVariant, RecapCardLockedVariant } from './components/RecapCard/RecapCard';
export { DotsPlanningItem } from './components/DotsPlanningItem/DotsPlanningItem';
export type { DotsPlanningItemProps, DotsPlanningInfoItem } from './components/DotsPlanningItem/DotsPlanningItem';
export { DotsPlanSelector } from './components/DotsPlanSelector/DotsPlanSelector';
export type { DotsPlanSelectorProps, DotsPlanSelectorVariant } from './components/DotsPlanSelector/DotsPlanSelector';
