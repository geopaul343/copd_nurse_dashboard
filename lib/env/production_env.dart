

import 'env.dart';

class ProductionEnv extends Env {
  ProductionEnv() : super(domainUrl: '');
  @override
  String toString() {
    return 'Production';
  }
}