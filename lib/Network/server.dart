import 'dart:convert';
import 'package:corona/Models/brief.dart';
import 'package:async_resource/async_resource.dart';
import 'package:async_resource/file_resource.dart';
import 'package:path_provider/path_provider.dart';

String serverurl =
    "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu";

class covidService {
  Future<Brief> fetchbrief() async {
    final path = (await getApplicationDocumentsDirectory()).path;
    final brief = HttpNetworkResource(
      url: serverurl + "/brief",
      parser: (contents) => json.decode(contents),
      cache: FileResource(File('$path/brief.json')),
      maxAge: Duration(minutes: 2),
      strategy: CacheStrategy.networkFirst,
    );
    final myData = await brief.get();
    return Brief.fromJson(myData);
  }
}
