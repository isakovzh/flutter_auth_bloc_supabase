import 'package:app/core/error/execption.dart';
import 'package:app/feature/profile/data/models/profilie_deteils_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ProfileDetailsModel> getProfileDetails(String id);
  Future<void> updateProfileDetails(ProfileDetailsModel model);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<ProfileDetailsModel> getProfileDetails(String id) async {
    try {
      final response = await supabaseClient
          .from('profile_details')
          .select()
          .eq('id', id)
          .single();

      return ProfileDetailsModel.fromJson(response);
    } catch (e) {
      throw ServerException('Failed to fetch profile details: $e');
    }
  }

  @override
  Future<void> updateProfileDetails(ProfileDetailsModel model) async {
    try {
      await supabaseClient
          .from('profile_details')
          .update(model.toJson())
          .eq('id', model.id);
    } catch (e) {
      throw ServerException('Failed to update profile details: $e');
    }
  }
}
