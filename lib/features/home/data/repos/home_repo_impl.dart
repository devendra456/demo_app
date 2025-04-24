import 'package:demo_app/app/core/network/network_info.dart';
import 'package:demo_app/features/home/domain/repos/home_repo.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../app/core/error/error_handler.dart';
import '../../../../app/core/error/failure.dart';
import '../../../../app/core/network/api_base_client.dart';
import '../../../../app/core/network/api_routes.dart';
import '../req_models/user_req.dart';
import '../res_models/user_model/user_model.dart';

class HomeRepoImpl implements HomeRepo {
  final NetworkInfo networkInfo;

  HomeRepoImpl({required this.networkInfo});

  @override
  Future<Either<Failure, List<UserModel>>> loadUser(UserReq req) async {
    if (!await networkInfo.isConnected()) {
      return Left(DataSource.noInternetConnection.getFailure());
    }
    try {
      final Map<String, dynamic> data = {
        'page': req.page,
        'results': req.results,
      };
      if (req.gender != null) {
        data.addAll({'gender': req.gender});
      }
      final response = await ApiBaseClient.client.get(
        APIRoutes.users,
        queryParameters: data,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final List<dynamic> results = data['results'];

        // Convert JSON to UserModel objects
        final List<UserModel> users =
            results.map((userData) => UserModel.fromJson(userData)).toList();

        return Right(users);
      } else {
        return Left(DataSource.default_.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
