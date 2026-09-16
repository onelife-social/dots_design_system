// UsersList — port of lib/src/components/users_list/users_list.dart
// (+ users_item_list.dart → UsersList.Item with `variant` = UserItemListVariant).
// Dart = source of truth.
import { DotsCloseButton } from '../DotsCloseButton/DotsCloseButton';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsMainButton, type DotsMainButtonVariant } from '../DotsMainButton/DotsMainButton';
import { UserInfo, type UserInfoSize } from '../UserItem/UserItem';

/** Dart enum UserItemListVariant */
export type UsersListItemVariant =
  | 'main'
  | 'label'
  | 'textfield'
  | 'button'
  | 'pending'
  | 'join'
  | 'waiting'
  | 'basic'
  | 'existingAlias'
  | 'pendingMember';

const VARIANTS: Record<UsersListItemVariant, true> = {
  main: true,
  label: true,
  textfield: true,
  button: true,
  pending: true,
  join: true,
  waiting: true,
  basic: true,
  existingAlias: true,
  pendingMember: true,
};

/** Dart enum MemberType */
export type UsersListMemberType = 'creator' | 'admin' | 'friend' | 'alias' | 'member' | 'existingAlias';

/** List member — Dart MemberInfo + UserInfoData flattened. */
export interface UsersListMember {
  id?: string;
  name: string;
  details?: string;
  /** Avatar URL */
  src?: string;
  /** Alias circle text */
  alias?: string;
  /** Dart enum MemberType. Index 0 is always painted as the creator. */
  memberType: UsersListMemberType;
}

/**
 * UsersList — web port of UsersList (Flutter). r26 container with one row per member
 * according to its MemberType, plus trailing add buttons.
 */
export interface UsersListProps {
  /** Members; the first one is always the creator. Empty → renders nothing. */
  members: UsersListMember[];
  /** Creator label (green trailing label) */
  creatorLabel: string;
  /** Admin label */
  adminLabel: string;
  /** Tap on a member; receives its id (Dart memberOnTap) */
  memberOnClick?: (id: string) => void;
  /** Placeholder of the alias textfields */
  textfieldLabel?: string;
  /** Change in an alias textfield: (id, value) (Dart textOnChanged) */
  textOnChange?: (id: string, value: string) => void;
  /** Label of the 'add participant' button (ic-add); both label and tap are required to show it */
  addParticipantLabel?: string;
  /** Tap of the 'add participant' button (Dart addParticipantOnTap) */
  addParticipantOnClick?: (id?: string) => void;
  /** Label of the 'add friend' button (ic-user) */
  addFriendLabel?: string;
  /** Tap of the 'add friend' button (Dart addFriendOnTap) */
  addFriendOnClick?: (id?: string) => void;
  /** Show the 'add friend' button. Default false */
  showAddFriendButton?: boolean;
  /** member → `join` row (chevron) instead of `basic`. Default false */
  canModifyMembers?: boolean;
  /** Autofocus on empty textfields. Default true */
  autofocusOnEmpty?: boolean;
  className?: string;
}

/**
 * UsersList.Item — web port of UsersItemList. A single row with its variant.
 */
export interface UsersListItemProps {
  /** Dart enum UserItemListVariant */
  variant: UsersListItemVariant;
  id?: string;
  /** User data (variants with UserInfo) */
  name?: string;
  details?: string;
  src?: string;
  alias?: string;
  /** (label/button/textfield) Label / placeholder */
  label?: string;
  /** (button) DotsIcon name. Default 'ic-add' */
  icon?: string;
  /** (textfield) Initial value (max 50 chars) */
  textValue?: string;
  /** (textfield) (id, value) on change */
  textOnChange?: (id: string, value: string) => void;
  /** (textfield) Autofocus when empty. Default true */
  autofocusOnEmpty?: boolean;
  /** (pending/join) Trailing icon size */
  iconSize?: number;
  /** Row tap (a native button named by `name`, or `label` for the button rows) / close button; receives the id */
  onClick?: (id: string) => void;
  /** (pendingMember) Button 1 (main) label */
  buttonLabel1?: string;
  /** (pendingMember) Button 2 (secondary) label */
  buttonLabel2?: string;
  /** (pendingMember) Button 1 tap; receives the id */
  onButton1Click?: (id: string) => void;
  /** (pendingMember) Button 2 tap; receives the id */
  onButton2Click?: (id: string) => void;
  className?: string;
}

function mainButton(label: string | undefined, variant: DotsMainButtonVariant, onClick: () => void) {
  return <DotsMainButton label={label || ''} variant={variant} size="small" expand={false} onClick={onClick} />;
}

// UsersItemList — one row (leading + trailing per variant)
export function UsersListItem(props: UsersListItemProps) {
  const variant: UsersListItemVariant = VARIANTS[props.variant] ? props.variant : 'main';
  const tapValue = props.id ?? '';
  function tap() {
    props.onClick?.(tapValue);
  }

  // _MainWidget
  let main;
  if (variant === 'textfield') {
    main = (
      <input
        className="ds-users-item__textfield"
        type="text"
        placeholder={props.label || ''}
        defaultValue={props.textValue || ''}
        maxLength={50} // LengthLimitingTextInputFormatter(50)
        autoFocus={props.autofocusOnEmpty !== false && !(props.textValue || '').length}
        onChange={props.textOnChange ? (e) => props.textOnChange?.(tapValue, e.target.value) : undefined}
      />
    );
  } else if (variant === 'button') {
    main = (
      <span className="ds-users-item__add">
        <DotsIcon name={props.icon || 'ic-add'} size={16} color="var(--label-highlight)" />
        <span>{props.label || ''}</span>
      </span>
    );
  } else {
    // waiting / pendingMember → UserInfoSize.large, the rest small
    const size: UserInfoSize = variant === 'waiting' || variant === 'pendingMember' ? 'large' : 'small';
    main = <UserInfo name={props.name ?? ''} details={props.details} src={props.src} alias={props.alias} size={size} />;
  }

  // _TrailingWidget
  let trailing = null;
  if (variant === 'main' || variant === 'textfield') {
    trailing = <DotsCloseButton size="extraSmall" onClick={tap} />;
  } else if (variant === 'pending' || variant === 'join') {
    trailing = (
      <span className="ds-users-item__trail-icon">
        <DotsIcon
          name={variant === 'join' ? 'ic-chevron-right' : 'ic-clock-filled'}
          size={props.iconSize ?? (variant === 'join' ? 14 : 16)}
          color="var(--text-secondary)"
        />
      </span>
    );
  } else if (variant === 'label') {
    trailing = <span className="ds-users-item__role">{props.label || ''}</span>;
  } else if (variant === 'pendingMember') {
    trailing = (
      <span className="ds-users-item__btns">
        {mainButton(props.buttonLabel1, 'main', () => props.onButton1Click?.(tapValue))}
        {mainButton(props.buttonLabel2, 'secondary', () => props.onButton2Click?.(tapValue))}
      </span>
    );
  }

  // The rows that hold native controls (close button / button pair) are never tappable as a whole
  const clickableRow = variant !== 'textfield' && variant !== 'main' && variant !== 'pendingMember';
  const rowClickable = clickableRow && !!props.onClick;
  return (
    <div className={`ds-users-item ds-users-item--${variant}${props.className ? ` ${props.className}` : ''}`}>
      {/* Row tap: a transparent native button that covers the row, rendered as the first child and a
          sibling of the row content — not as a role=button row, which would make any nested control
          presentational. */}
      {rowClickable ? <button type="button" className="ds-users-list__hit" aria-label={props.name || props.label} onClick={tap} /> : null}
      {main}
      {trailing}
    </div>
  );
}

// UsersList — r26 bgContainerSecondaryOnBackground container with dividers
export function UsersList(props: UsersListProps) {
  const members = props.members || [];
  if (!members.length) return null;

  const items = members.map((m, index) => {
    const key = m.id ?? `m${index}`;
    const base = { id: m.id, name: m.name, details: m.details, src: m.src, alias: m.alias };

    // Creator — always index 0 (Dart)
    if (index === 0) return <UsersListItem key={key} {...base} variant="label" label={props.creatorLabel} />;

    switch (m.memberType) {
      case 'creator':
        return null; // already handled above (Dart: Offstage)
      case 'admin':
        return <UsersListItem key={key} {...base} variant="label" label={props.adminLabel} onClick={props.memberOnClick} />;
      case 'friend':
        return <UsersListItem key={key} {...base} variant="main" onClick={props.memberOnClick} />;
      case 'member':
        return props.canModifyMembers ? (
          <UsersListItem key={key} {...base} variant="join" onClick={props.memberOnClick} iconSize={22} />
        ) : (
          <UsersListItem key={key} {...base} variant="basic" />
        );
      case 'existingAlias':
        return <UsersListItem key={key} {...base} variant="existingAlias" />;
      case 'alias':
        return (
          <UsersListItem
            key={key}
            {...base}
            variant="textfield"
            label={props.textfieldLabel || ''}
            textValue={m.name}
            onClick={props.memberOnClick}
            textOnChange={props.textOnChange}
            autofocusOnEmpty={props.autofocusOnEmpty}
          />
        );
      default:
        return <UsersListItem key={key} {...base} variant="basic" />;
    }
  });

  // Add buttons at the end (Dart)
  if (props.addParticipantLabel && props.addParticipantOnClick) {
    items.push(
      <UsersListItem key="__add-participant" variant="button" label={props.addParticipantLabel} icon="ic-add" onClick={props.addParticipantOnClick} />,
    );
  }
  if (props.showAddFriendButton && props.addFriendLabel && props.addFriendOnClick) {
    items.push(
      <UsersListItem key="__add-friend" variant="button" label={props.addFriendLabel} icon="ic-user" onClick={props.addFriendOnClick} />,
    );
  }

  return <div className={`ds-users-list${props.className ? ` ${props.className}` : ''}`}>{items}</div>;
}
UsersList.Item = UsersListItem;
