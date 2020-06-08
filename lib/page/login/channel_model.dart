import 'package:json_annotation/json_annotation.dart';

part 'channel_model.g.dart';

@JsonSerializable(nullable: false)
class ChannelModel {
  List<Channels> channels;

  ChannelModel({this.channels});

  ChannelModel.fromJson(Map<String, dynamic> json) {
    if (json['channels'] != null) {
      channels = new List<Channels>();
      json['channels'].forEach((v) {
        channels.add(new Channels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.channels != null) {
      data['channels'] = this.channels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@JsonSerializable(nullable: false)
class Channels {
  String nameEn;
  int seqId;
  String abbrEn;
  String name;
  int channelId;

  Channels({this.nameEn, this.seqId, this.abbrEn, this.name, this.channelId});

  Channels.fromJson(Map<String, dynamic> json) {
    nameEn = json['name_en'];
    seqId = json['seq_id'];
    abbrEn = json['abbr_en'];
    name = json['name'];
    channelId = json['channel_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_en'] = this.nameEn;
    data['seq_id'] = this.seqId;
    data['abbr_en'] = this.abbrEn;
    data['name'] = this.name;
    data['channel_id'] = this.channelId;
    return data;
  }
}