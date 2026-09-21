import * as React from 'react';

/** Dart enum UserItemListVariant */
export type UsersListItemVariant = 'main' | 'label' | 'textfield' | 'button' | 'pending' | 'join' | 'waiting' | 'basic' | 'existingAlias' | 'pendingMember';
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
    /** Row tap (a native button named by `name`, or `label` for the button rows); on main/textfield the close
     *  button fires it too — Dart wires both to the same onTap. Receives the id */
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
export declare function UsersListItem(props: UsersListItemProps): import("react").JSX.Element;
export declare function UsersList(props: UsersListProps): import("react").JSX.Element | null;
export declare namespace UsersList {
    var Item: typeof UsersListItem;
}
