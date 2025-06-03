import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsMenuDemoPage extends StatefulWidget {
  const DotsMenuDemoPage({super.key});

  @override
  State<DotsMenuDemoPage> createState() => _DotsMenuDemoPageState();
}

class _DotsMenuDemoPageState extends State<DotsMenuDemoPage> {
  Widget? menuToShow;

  void _showDotsMenu() {
    menuToShow = Positioned(
      left: 80,
      top: 80,
      child: DotsMenu(
        mainItem: item,
        subitems: subItems,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.dotsTheme.colors.bgContainerSecondary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              top: 10,
              child: Center(
                child: DotsMainButton(
                  expand: false,
                  content: 'Show menu',
                  onTap: () {
                    _showDotsMenu();
                  },
                ),
              )),
          menuToShow ?? SizedBox(),
        ],
      ),
    );
  }
}

DotsMenuItemModel item = DotsMenuItemModel(
  id: 'hide_photos',
  label: 'Ocultar fotos con las que no he interactuado',
  icon: DotsIconData.eyeOff,
);

List<DotsMenuItemModel> subItems = [
  DotsMenuItemModel(id: 'sort_photos', label: 'Ordenar por', icon: DotsIconData.sort, subItems: [
    DotsMenuItemModel(
      id: 'sort_by_date',
      label: 'Foto más reciente',
      icon: DotsIconData.clockTimer,
      selected: true,
    ),
    DotsMenuItemModel(
      id: 'sort_by_oldest',
      label: 'Foto más antigua',
      icon: DotsIconData.order,
    ),
  ]),
  DotsMenuItemModel(
      id: 'filter_photos',
      label: 'Filtrar',
      details: 'Imágenes',
      icon: DotsIconData.filter,
      subItems: [
        DotsMenuItemModel(
          id: 'filter_images',
          label: 'Imágenes',
          selected: true,
        ),
        DotsMenuItemModel(
          id: 'filter_videos',
          label: 'Favoritos',
        ),
        DotsMenuItemModel(
          id: 'filter_videos',
          label: 'Vídeos',
        ),
        DotsMenuItemModel(
          id: 'filter_selfies',
          label: 'Selfies',
        ),
        DotsMenuItemModel(
          id: 'filter_live_photos',
          label: 'Live Photos',
        ),
        DotsMenuItemModel(
          id: 'filter_panorama',
          label: 'Panorámicas',
        ),
        DotsMenuItemModel(
          id: 'filter_portraits',
          label: 'Retratos',
        ),
        DotsMenuItemModel(
          id: 'filter_screenshots',
          label: 'Capturas de pantalla',
        ),
        DotsMenuItemModel(
          id: 'filter_other',
          label: 'Más de otras cosas',
        ),
      ]),
  DotsMenuItemModel(
    id: 'delete_filters',
    label: 'Eliminar filtros',
    isDelete: true,
    icon: DotsIconData.remove,
  ),
];
