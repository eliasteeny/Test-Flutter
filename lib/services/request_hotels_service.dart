import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:task_job/utilities/globals.dart' as globals;

String url = globals.domainURL + "v2/5d74fb9d310000d81595054d";

Future<http.Response> request_hotels() async {
  bool isError = false;
  http.Response response;
  response = await http.get('$url').catchError((error) {
    print(error);
    isError = true;
  });
  if (!isError) {
    return response;
  }
}
