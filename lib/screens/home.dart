import 'dart:ui';
import 'package:ceplocation/data/cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CepRepository>(
        init: CepRepository(),
        builder: (controller) {
          return Form(
            key: controller.formKey,
            child: controller.loading.value == true
                ? Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Carregando...',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 13,
                              decoration: TextDecoration.none,
                              letterSpacing: 2),
                        )
                      ],
                    ))
                : Scaffold(
                    appBar: AppBar(
                      backgroundColor: const Color.fromARGB(255, 125, 170, 126),
                      title: const Text('Consulte a localização do seu CEP'),
                    ),
                    body: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: controller.ceptxt,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Exemplo: 24420-869'),
                            maxLength: 8,
                            validator: (s) {
                              if (s!.isEmpty) {
                                return 'nenhum CEP digitado';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (cepRepo.formKey.currentState!
                                          .validate()) {
                                        controller.cepRequest();
                                      }
                                    },
                                    child: const Text(
                                      'Consultar',
                                      style: TextStyle(fontSize: 16),
                                    )),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              SizedBox(
                                width: 165,
                                height: 38,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                    onPressed: () {
                                      controller.launchMap();
                                    },
                                    child: Row(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(right: 2),
                                          child:
                                              Icon(Icons.location_on, size: 20),
                                        ),
                                        Text(
                                          'Pesquise no Mapa',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            '${controller.result}',
                            style: const TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
