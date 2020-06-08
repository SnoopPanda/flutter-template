// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelModel _$ChannelModelFromJson(Map<String, dynamic> json) {
  return ChannelModel(
    channels: (json['channels'] as List)
        .map((e) => Channels.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ChannelModelToJson(ChannelModel instance) =>
    <String, dynamic>{
      'channels': instance.channels,
    };

Channels _$ChannelsFromJson(Map<String, dynamic> json) {
  return Channels(
    nameEn: json['nameEn'] as String,
    seqId: json['seqId'] as int,
    abbrEn: json['abbrEn'] as String,
    name: json['name'] as String,
    channelId: json['channelId'] as int,
  );
}

Map<String, dynamic> _$ChannelsToJson(Channels instance) => <String, dynamic>{
      'nameEn': instance.nameEn,
      'seqId': instance.seqId,
      'abbrEn': instance.abbrEn,
      'name': instance.name,
      'channelId': instance.channelId,
    };
