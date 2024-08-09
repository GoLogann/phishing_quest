import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:phishing_quest/app/modules/home_page/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0, // Ajusta a posição vertical do bloco cinza
              left: 0, // Ajusta a posição horizontal do bloco cinza
              right: 0,
              child: Container(
                width: double.infinity, // Faz o bloco cinza ocupar toda a largura disponível
                height: 100,
                color: Colors.grey[300],
              ),
            ),
            Positioned(
              top: 60, // Ajusta a posição vertical do bloco laranja para sobrepor o bloco cinza
              left: 100, // Ajusta a posição horizontal do bloco laranja
              child: Container(
                width: 200,
                height: 50,
                color: Colors.orange[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
