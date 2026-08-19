import * as React from 'react';

/** Miembro de la lista — Dart MemberInfo + UserInfoData aplanados. */
export interface UsersListMember {
  id?: string;
  name: string;
  details?: string;
  /** URL del avatar. */
  src?: string;
  /** Texto del círculo de alias. */
  alias?: string;
  /** Enum Dart MemberType. El índice 0 siempre se pinta como creador. */
  memberType: 'creator' | 'admin' | 'friend' | 'alias' | 'member' | 'existingAlias';
}

/**
 * UsersList — port web de UsersList (Flutter). Contenedor r26 con filas de
 * miembros según su MemberType y botones de añadir al final.
 */
export interface UsersListProps {
  /** Miembros; el primero es siempre el creador. Vacío → no se renderiza nada. */
  members: UsersListMember[];
  /** Etiqueta del creador (trailing label verde). */
  creatorLabel: string;
  /** Etiqueta del admin. */
  adminLabel: string;
  /** Tap en un miembro; recibe su id (Dart memberOnTap). */
  memberOnClick?: (id: string) => void;
  /** Placeholder de los textfield de alias. */
  textfieldLabel?: string;
  /** Cambio en un textfield de alias: (id, value) (Dart textOnChanged). */
  textOnChange?: (id: string, value: string) => void;
  /** Etiqueta y tap del botón 'añadir participante' (icono ic-add). */
  addParticipantLabel?: string;
  addParticipantOnClick?: (id?: string) => void;
  /** Etiqueta y tap del botón 'añadir amigo' (icono ic-user). */
  addFriendLabel?: string;
  addFriendOnClick?: (id?: string) => void;
  /** Mostrar el botón 'añadir amigo'. Default false. */
  showAddFriendButton?: boolean;
  /** member → fila `join` (chevron) en vez de `basic`. Default false. */
  canModifyMembers?: boolean;
  /** Autofocus en textfields vacíos. Default true. */
  autofocusOnEmpty?: boolean;
  className?: string;
}

/**
 * UsersList.Item — port web de UsersItemList. Una fila suelta con su variante.
 */
export interface UsersListItemProps {
  /** Variante — enum Dart UserItemListVariant. */
  variant:
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
  id?: string;
  /** Datos de usuario (variantes con UserInfo). */
  name?: string;
  details?: string;
  src?: string;
  alias?: string;
  /** (label/button/textfield) Etiqueta / placeholder. */
  label?: string;
  /** (button) Nombre DotsIcon. Default 'ic-add'. */
  icon?: string;
  /** (textfield) Valor inicial (máx. 50 caracteres). */
  textValue?: string;
  /** (textfield) (id, value) al cambiar. */
  textOnChange?: (id: string, value: string) => void;
  /** (textfield) Autofocus si está vacío. Default true. */
  autofocusOnEmpty?: boolean;
  /** (pending/join) Tamaño del icono trailing. */
  iconSize?: number;
  /** Tap de la fila / botón de cierre; recibe el id. */
  onClick?: (id: string) => void;
  /** (pendingMember) Botón 1 (main) y botón 2 (secondary). */
  buttonLabel1?: string;
  buttonLabel2?: string;
  onButton1Click?: (id: string) => void;
  onButton2Click?: (id: string) => void;
  className?: string;
}

export declare const UsersList: React.ComponentType<UsersListProps> & {
  Item: React.ComponentType<UsersListItemProps>;
};
