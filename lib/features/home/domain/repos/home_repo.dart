import 'package:fpdart/fpdart.dart';

import '../../../../app/core/error/failure.dart';
import '../../data/req_models/user_req.dart';
import '../../data/res_models/user_model/user_model.dart';

abstract interface class HomeRepo {
  Future<Either<Failure, List<UserModel>>> loadUser(UserReq req);
}
