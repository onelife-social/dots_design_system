import * as React from 'react';

/**
 * UserItem.Info — port web de UserInfo (Flutter). Avatar circular (imagen, alias
 * o placeholder degradado con iniciales) + nombre y detalles opcionales.
 */
export interface UserInfoProps {
  /** Nombre del usuario (UserInfoData.name). */
  name: string;
  /** Línea secundaria (UserInfoData.details). */
  details?: string;
  /** URL del avatar (UserInfoData.imageProvider). */
  src?: string;
  /** Texto del círculo de alias (UserInfoData.aliasLabelImageText). */
  alias?: string;
  /** Tamaño — enum Dart UserInfoSize (avatar 26 / 40). Default 'small'. */
  size?: 'small' | 'large';
  /** Callback si el avatar falla al cargar (UserInfoData.imageOnError). */
  onError?: (event: unknown) => void;
  className?: string;
}

/**
 * UserItem — port web de UserItem (Flutter). Píldora 170×45 (squircle24, bgStrong,
 * sombra flotante) con UserInfo small + icono addCircle labelHighlight.
 */
export interface UserItemProps {
  /** Id del usuario; se pasa al onClick. */
  id?: string;
  /** Nombre a mostrar. */
  name: string;
  details?: string;
  src?: string;
  alias?: string;
  /** Callback al pulsar, recibe el id (Dart onTap(id)). */
  onClick?: (id: string | null) => void;
  onError?: (event: unknown) => void;
  className?: string;
}

export declare const UserItem: React.ComponentType<UserItemProps> & {
  Info: React.ComponentType<UserInfoProps>;
};
