import 'package:json_annotation/json_annotation.dart';

part 'nodes_info.g.dart';

@JsonSerializable()
class Masternode {
  final String ipv4;
  final int port;
  final String address;
  final int consecutivePayments;

  Masternode({
    required this.ipv4,
    required this.port,
    required this.address,
    required this.consecutivePayments,
  });

  factory Masternode.fromJson(Map<String, dynamic> json) {
    return Masternode(
      ipv4: json['ipv4'] ?? '',
      port: json['port'] ?? 0,
      address: json['address'] ?? '',
      consecutivePayments: json['consecutive_payments'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => _$MasternodeToJson(this);
}

@JsonSerializable()
class NodesInfo {
  @JsonKey(name: 'block_id')
  final int blockId;
  final double reward;
  final int count;
  final List<Masternode> masternodes;

  NodesInfo({
    required this.blockId,
    required this.reward,
    required this.count,
    required this.masternodes,
  });

  factory NodesInfo.fromJson(Map<String, dynamic> json) {
    return NodesInfo(
      blockId: json['block_id'] ?? 0,
      reward: json['reward'] != null ? json['reward'].toDouble() : 0.0,
      count: json['count'] ?? 0,
      masternodes: (json['masternodes'] as List<dynamic>?)
              ?.map((nodeJson) => Masternode.fromJson(nodeJson))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => _$NodesInfoToJson(this);

  NodesInfo copyWith({
    int? blockId,
    double? reward,
    int? count,
    List<Masternode>? masternodes,
  }) {
    return NodesInfo(
      blockId: blockId ?? this.blockId,
      reward: reward ?? this.reward,
      count: count ?? this.count,
      masternodes: masternodes ?? this.masternodes,
    );
  }
}
