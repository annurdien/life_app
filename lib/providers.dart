import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/firebase.dart';
import 'routes/router.dart';

/// Dependency Injection

final routerProvider = ChangeNotifierProvider<AppRouter>((ref) => AppRouter());
final appQueryProvider = Provider((ref) => FirebaseQuery());
