// @dots/design-system — public surface. One export line per component.
// Components not yet ported to TSX still live in ../tool/design_sync/_src (legacy bundle format,
// only for the Claude Design bundle): port a component here when an app needs it.
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
export { DotsCalendar } from './components/DotsCalendar/DotsCalendar';
export type { DotsCalendarProps } from './components/DotsCalendar/DotsCalendar';
