import 'package:json_annotation/json_annotation.dart';

import '../enums/poh_profile_status.dart';
import 'json_helpers.dart';

part 'poh_profile.g.dart';

@JsonSerializable()
class PohProfile {
  @JsonKey(name: 'eth_address')
  final String address;
  final PohProfileStatus status;
  @JsonKey(name: 'vanity_id')
  final int vanityId;
  @JsonKey(name: 'display_name')
  final String displayName;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final bool registered;
  @JsonKey(name: 'photo')
  final String photoUrl;
  @JsonKey(name: 'video')
  final String videoUrl;
  final String bio;
  @JsonKey(name: 'profile')
  final String profileUrl;
  @JsonKey(name: 'registered_time', fromJson: dateTimeFromString)
  final DateTime dateRegistered;
  @JsonKey(name: 'creation_time', fromJson: dateTimeFromString)
  final DateTime dateCreated;

  factory PohProfile.fromJson(Map<String, dynamic> json) =>
      _$PohProfileFromJson(json);

  const PohProfile({
    required this.address,
    required this.status,
    required this.vanityId,
    required this.displayName,
    required this.firstName,
    required this.lastName,
    required this.registered,
    required this.photoUrl,
    required this.videoUrl,
    required this.bio,
    required this.profileUrl,
    required this.dateRegistered,
    required this.dateCreated,
  });
}
