import 'dart:convert';

import 'package:functions_framework/functions_framework.dart';

@CloudFunction()
void function(CloudEvent event, RequestContext context) {
  final eventJson = json.encode(event.toJson());
  context.logger.info('[CloudEvent] json: $eventJson');
}
