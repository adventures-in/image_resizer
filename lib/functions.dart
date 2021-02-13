import 'dart:convert';
import 'dart:io';

import 'package:dartimageresize/src/pub_sub.dart';
import 'package:functions_framework/functions_framework.dart';

const _encoder = JsonEncoder.withIndent(' ');

@CloudFunction()
void function(CloudEvent event, RequestContext context) {
  // context.logger
  //     .info('[CloudEvent] source: ${event.source}, subject: ${event.subject}');

  // final pubSub = PubSub.fromJson(event.data as Map<String, dynamic>);
  // context.logger.info('PubSub: $pubSub');

  context.logger.info('CloudEvent toJson: ${event.toJson()}');

  // stderr.writeln(_encoder.convert(event));
}
