// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_base_project/core/localization/language_cubit.dart'
    as _i550;
import 'package:flutter_base_project/core/network/dio_client.dart' as _i946;
import 'package:flutter_base_project/core/network/dio_client_impl.dart' as _i96;
import 'package:flutter_base_project/core/network/network_info.dart' as _i567;
import 'package:flutter_base_project/core/network/network_info_impl.dart'
    as _i333;
import 'package:flutter_base_project/features/user/data/datasources/user_api_service.dart'
    as _i214;
import 'package:flutter_base_project/features/user/data/datasources/user_api_service_impl.dart'
    as _i244;
import 'package:flutter_base_project/features/user/data/repositories/user_repository_impl.dart'
    as _i869;
import 'package:flutter_base_project/features/user/domain/repositories/user_repository.dart'
    as _i1024;
import 'package:flutter_base_project/features/user/domain/usecases/get_current_user.dart'
    as _i227;
import 'package:flutter_base_project/features/user/presentation/bloc/user_bloc.dart'
    as _i811;
import 'package:flutter_base_project/root/presentation/cubit/root_cubit.dart'
    as _i1053;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i550.LanguageCubit>(() => _i550.LanguageCubit());
    gh.factory<_i1053.RootCubit>(() => _i1053.RootCubit());
    gh.lazySingleton<_i946.DioClient>(() => _i96.DioClientImpl());
    gh.lazySingleton<_i567.NetworkInfo>(() => _i333.NetworkInfoImpl());
    gh.lazySingleton<_i214.UserApiService>(
        () => _i244.UserApiServiceImpl(gh<_i946.DioClient>()));
    gh.lazySingleton<_i1024.UserRepository>(() => _i869.UserRepositoryImpl(
          apiService: gh<_i214.UserApiService>(),
          networkInfo: gh<_i567.NetworkInfo>(),
        ));
    gh.factory<_i227.GetCurrentUser>(
        () => _i227.GetCurrentUser(gh<_i1024.UserRepository>()));
    gh.factory<_i811.UserBloc>(
        () => _i811.UserBloc(getCurrentUser: gh<_i227.GetCurrentUser>()));
    return this;
  }
}
