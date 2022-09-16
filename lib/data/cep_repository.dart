import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

CepRepository cepRepo = Get.put(CepRepository());

class CepRepository extends GetxController {
  TextEditingController ceptxt = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool loading = false.obs;
  RxString result = ''.obs;

  cepRequest() async {
    String cep = ceptxt.text;
    var dio = Dio();
    try {
      loading.value = true;
      final responses = await dio.get('https://viacep.com.br/ws/$cep/json/');
      String log = responses.data['logradouro'];
      String bai = responses.data['bairro'];
      String loc = responses.data['localidade'];
      String uf = responses.data['uf'];
      result.value = "$log, $bai, $loc, $uf";
      loading.value = false;
      return result.value;
    } catch (Unhandled) {
      loading.value = true;
      print('Erro');
      result.value = "O CEP digitado não existe.";
      loading.value = false;
      return result.value;
    }
  }

  launchMap() async {
    String url =
        'https://www.google.com.br/url?sa=t&source=web&rct=j&url=https://www.google.com.br/maps&ved=2ahUKEwjr-bz_v5j6AhX7pZUCHXu5B5cQFnoECAUQAQ&usg=AOvVaw3cFx2-7_OaqMQ-d44zdcXo';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
