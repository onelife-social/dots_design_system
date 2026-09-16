import * as React from 'react';

import { type SyntheticEvent } from 'react';
/** Dart enum UserInfoSize (avatar 26 / 40) */
export type UserInfoSize = 'small' | 'large';
/**
 * UserItem.Info — web port of UserInfo (Flutter). Circular avatar (image, alias or
 * gradient placeholder with initials) + name and optional details.
 */
export interface UserInfoProps {
    /** User name (UserInfoData.name) */
    name: string;
    /** Secondary line (UserInfoData.details) */
    details?: string;
    /** Avatar URL (UserInfoData.imageProvider) */
    src?: string;
    /** Alias circle text (UserInfoData.aliasLabelImageText) */
    alias?: string;
    /** Dart enum UserInfoSize (avatar 26 / 40). Default 'small' */
    size?: UserInfoSize;
    /** Avatar load error callback (UserInfoData.imageOnError) */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
    className?: string;
}
/**
 * UserItem — web port of UserItem (Flutter). 170×45 pill (squircle24, bgStrong,
 * floating shadow) with UserInfo small + addCircle labelHighlight icon.
 */
export interface UserItemProps {
    /** User id; passed to onClick */
    id?: string;
    /** Name to display */
    name: string;
    /** Secondary line */
    details?: string;
    /** Avatar URL */
    src?: string;
    /** Alias circle text when there is no image */
    alias?: string;
    /** Tap callback, receives the id (Dart onTap(id)) */
    onClick?: (id: string | null) => void;
    /** Avatar load error callback */
    onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
    className?: string;
}
export declare function UserInfo(props: UserInfoProps): import("react").JSX.Element;
export declare function UserItem(props: UserItemProps): import("react").JSX.Element;
export declare namespace UserItem {
    var Info: typeof UserInfo;
}
