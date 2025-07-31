

import 'env.dart';

class DevelopmentEnv extends Env {
  DevelopmentEnv() : super(domainUrl: 'https://app-audio-analyzer-887192895309.us-central1.run.app');
  @override
  String toString() {
    return 'Development';
  }
}