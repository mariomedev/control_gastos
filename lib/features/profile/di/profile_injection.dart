import 'package:get_it/get_it.dart';

import '../../../core/core.dart';
import '../profile_feature.dart';

final locator = GetIt.instance;

void initProfileInjection() {
  // ============= DATASOURCES =============
  locator.registerSingleton<ThemeDataDomain>(
    DataThemeImpl(service: locator<SharedPreferencesService>()),
  );

  // ============= REPOSITORIES =============
  locator.registerSingleton<ThemeRepo>(
    ThemeRepoImpl(dataSource: locator<ThemeDataDomain>()),
  );

  // ============= USECASES =============
  locator.registerSingleton(GetColorScheme(locator<ThemeRepo>()));
  locator.registerSingleton(GetDarkMode(locator<ThemeRepo>()));
  locator.registerSingleton(SetColorScheme(locator<ThemeRepo>()));
  locator.registerSingleton(SetDarkMode(locator<ThemeRepo>()));

  // ============= BLOCS =============
  locator.registerSingleton<ThemeBloc>(
    ThemeBloc(
      getColorScheme: locator<GetColorScheme>(),
      getDarkMode: locator<GetDarkMode>(),
      setColorScheme: locator<SetColorScheme>(),
      setDarkMode: locator<SetDarkMode>(),
    ),
  );
}
