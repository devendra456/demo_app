import 'package:fpdart/fpdart.dart';

import '../error/failure.dart';

export 'no_params.dart';

mixin UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
