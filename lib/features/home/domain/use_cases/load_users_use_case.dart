import 'package:demo_app/app/core/error/failure.dart';
import 'package:demo_app/features/home/data/req_models/user_req.dart';
import 'package:demo_app/features/home/domain/entities/user_entity.dart';
import 'package:demo_app/features/home/domain/repos/home_repo.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../app/core/use_case/use_case.dart';

class LoadUsersUseCase implements UseCase<List<UserEntity>, UserReq> {
  final HomeRepo _homeRepo;

  LoadUsersUseCase({required HomeRepo homeRepo}) : _homeRepo = homeRepo;

  @override
  Future<Either<Failure, List<UserEntity>>> call(UserReq params) async {
    final res = await _homeRepo.loadUser(params);

    return res.map((a) {
      return a
          .map(
            (e) => UserEntity(
              email: e.email ?? "Email Not Available",
              name: Name(
                title: e.name?.title ?? "",
                first: e.name?.first ?? "",
                last: e.name?.last ?? "",
              ),
              picture: Picture(
                large: e.picture?.large ?? "",
                medium: e.picture?.medium ?? "",
                thumbnail: e.picture?.thumbnail ?? "",
              ),
              phone: e.phone ?? "Phone Number Not Available",
              gender: e.gender ?? "Gender Not Available",
              dob: Dob(
                date: e.dob?.date ?? DateTime.now(),
                age: e.dob?.age ?? 0,
              ),
              country: e.location?.country ?? "Country Not Available",
              postcode: "${e.location?.postcode ?? "Postcode Not Available"}",
              state: e.location?.state ?? "State Not Available",
              address:
                  "${e.location?.street?.number ?? ""} ${e.location?.street?.name ?? ""} ${e.location?.city ?? ""}",
            ),
          )
          .toList();
    });
  }
}
