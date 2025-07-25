import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/shared/local/cache/local_db.dart';
import 'package:kacha_test/shared/local/cache/local_db_impl.dart';
import 'package:kacha_test/shared/local/shared_prefs/shared_pref.dart';
import 'package:kacha_test/shared/local/shared_prefs/shared_pref_impl.dart';
import 'package:kacha_test/shared/network/dio_network_service.dart';
import 'package:kacha_test/shared/network/network_service.dart';

final networkServiceProvider = Provider<NetworkService>((ref) {
  return DioNetworkService();
});

final localDbProvider = Provider<LocalDb>((ref) {
  return InitDbImpl();
});

final sharedPrefProvider = Provider<SharedPref>((ref) {
  return SharedPrefImplementation();
});
