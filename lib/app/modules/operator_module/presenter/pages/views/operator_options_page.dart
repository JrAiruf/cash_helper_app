import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/options_page_menu_component.dart';
import "package:flutter/material.dart";
import 'package:flutter_modular/flutter_modular.dart';

class OperatorOptionsPage extends StatefulWidget {
  const OperatorOptionsPage(
      {super.key,
      required this.operatorId,
      this.position,
      required this.pageController});
  final String operatorId;
  final BottomNavigationBarPosition? position;
  final PageController? pageController;
  @override
  State<OperatorOptionsPage> createState() => _OperatorOptionsPageState();
}

class _OperatorOptionsPageState extends State<OperatorOptionsPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final tertiaryColor = Theme.of(context).colorScheme.onTertiaryContainer;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    final _operatorPageController = PageController();
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height * 0.28,
            width: width,
            decoration: BoxDecoration(
              color: seccondaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.03),
                const Icon(Icons.person, size: 85),
                SizedBox(height: height * 0.01),
                Text('Júnior Oliveira',
                    style: Theme.of(context).textTheme.displayMedium),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.adf_scanner_outlined),
                    SizedBox(width: width * 0.05),
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Text(
                          "2",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: height * 0.04),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OptionsPageMenuComponent(
                    elevation: 5,
                    itemName: "Listar Anotações",
                    radius: 15,
                    borderColor: Colors.white,
                    itemColor: seccondaryColor,
                    icon: Icons.view_list_outlined,
                    height: height * 0.18,
                    width: width * 0.38,
                  ),
                  OptionsPageMenuComponent(
                    elevation: 5,
                    itemName: "Pesquisar",
                    radius: 15,
                    borderColor: Colors.white,
                    itemColor: seccondaryColor,
                    icon: Icons.search,
                    height: height * 0.18,
                    width: width * 0.38,
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OptionsPageMenuComponent(
                    onTap: () => Modular.to.navigate("/annotations-module/"),
                    elevation: 5,
                    itemName: "Criar Anotação",
                    radius: 15,
                    borderColor: Colors.white,
                    itemColor: seccondaryColor,
                    icon: Icons.note_add_outlined,
                    height: height * 0.18,
                    width: width * 0.38,
                  ),
                  OptionsPageMenuComponent(
                    elevation: 5,
                    itemName: "Fechar Caixa",
                    radius: 15,
                    borderColor: Colors.white,
                    itemColor: seccondaryColor,
                    icon: Icons.power_settings_new_sharp,
                    height: height * 0.18,
                    width: width * 0.38,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
