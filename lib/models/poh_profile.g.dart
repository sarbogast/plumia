// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poh_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PohProfile _$PohProfileFromJson(Map<String, dynamic> json) => PohProfile(
      address: json['eth_address'] as String,
      status: $enumDecode(_$PohProfileStatusEnumMap, json['status']),
      vanityId: json['vanity_id'] as int,
      displayName: json['display_name'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      registered: json['registered'] as bool,
      photoUrl: json['photo'] as String,
      videoUrl: json['video'] as String,
      bio: json['bio'] as String,
      profileUrl: json['profile'] as String,
      dateRegistered: dateTimeFromString(json['registered_time'] as String),
      dateCreated: dateTimeFromString(json['creation_time'] as String),
    );

Map<String, dynamic> _$PohProfileToJson(PohProfile instance) =>
    <String, dynamic>{
      'eth_address': instance.address,
      'status': _$PohProfileStatusEnumMap[instance.status]!,
      'vanity_id': instance.vanityId,
      'display_name': instance.displayName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'registered': instance.registered,
      'photo': instance.photoUrl,
      'video': instance.videoUrl,
      'bio': instance.bio,
      'profile': instance.profileUrl,
      'registered_time': instance.dateRegistered.toIso8601String(),
      'creation_time': instance.dateCreated.toIso8601String(),
    };

const _$PohProfileStatusEnumMap = {
  PohProfileStatus.PENDING_REGISTRATION: 'PENDING_REGISTRATION',
  PohProfileStatus.DISPUTED_PENDING_REGISTRATION:
      'DISPUTED_PENDING_REGISTRATION',
  PohProfileStatus.DISPUTED_REMOVAL: 'DISPUTED_REMOVAL',
  PohProfileStatus.PENDING_REMOVAL: 'PENDING_REMOVAL',
  PohProfileStatus.VOUCHING: 'VOUCHING',
  PohProfileStatus.REGISTERED: 'REGISTERED',
  PohProfileStatus.EXPIRED: 'EXPIRED',
};
