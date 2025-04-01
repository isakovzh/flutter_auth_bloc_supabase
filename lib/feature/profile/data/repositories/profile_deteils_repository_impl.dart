import 'package:app/core/error/failure.dart';
import 'package:app/feature/profile/data/datasource/proflie_remote_datasource.dart';
import 'package:app/feature/profile/data/models/profilie_deteils_model.dart';
import 'package:app/feature/profile/domain/entities/proflie_deteils_entitie.dart';
import 'package:app/feature/profile/domain/repositories/profile_deteils_repository.dart';

import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProfileDetailsEntity>> getProfileDetails() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId == null) {
        return left(Failure('No current user ID found.'));
      }

      final model = await remoteDataSource.getProfileDetails(userId);
      return right(model);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfileDetails(ProfileDetailsEntity entity) async {
    try {
      final model = ProfileDetailsModel.fromEntity(entity);
      await remoteDataSource.updateProfileDetails(model);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
