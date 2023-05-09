// ignore_for_file: must_be_immutable
import 'package:cash_helper_app/app/modules/user_module/presenter/components/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';

class ManagerSectionDrawer extends StatelessWidget {
  ManagerSectionDrawer({super.key, this.radius, this.width});

  double? radius;
  double? width;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius ?? 5),
        bottomRight: Radius.circular(radius ?? 5),
      ),
      child: Drawer(
        backgroundColor: primaryColor,
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Text("Opções", style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 160),
              DrawerTile(
                  icon: Icons.home,
                  title: "Início",
                  width: width,
                  onTap: () => print("object")),
            ],
          ),
        ),
      ),
    );
  }
}
