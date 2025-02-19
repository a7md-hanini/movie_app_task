import 'dart:async';

class OPService {
  static final OPService _oPService = OPService._internal();

  dynamic itoken;

  StreamController<int> streamController = StreamController<int>();
  factory OPService() {
    return _oPService;
  }

  OPService._internal();
}

final oPService = OPService();
dynamic oPServiceSearch = OPService();
