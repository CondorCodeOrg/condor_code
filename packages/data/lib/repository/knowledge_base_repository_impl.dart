import 'dart:convert';

import 'package:data/data_sources/remote/manager/remote_data_manager.dart';
import 'package:domain/domain.dart';

class KnowledgeBaseRepositoryImpl implements KnowledgeBaseRepository {
  KnowledgeBaseRepositoryImpl({required this.remoteDataManager});

  final RemoteDataManager remoteDataManager;

  @override
  Future<DataResult<List<KnowledgeBaseNewsItem>>> fetchLatestNews() =>
      safeDataCall(
        dataCall: () => remoteDataManager.fetchKnowledgeBaseNews(),
        processResult: SuccessResult.new,
      );

  @override
  Future<DataResult<KnowledgeBaseRoadmapData>> fetchRoadmap() => safeDataCall(
    dataCall: () => remoteDataManager.fetchKnowledgeBaseRoadmapJson(),
    processResult: (jsonString) =>
        SuccessResult(_mapRoadmap(_decodeJson(jsonString))),
  );

  Map<String, dynamic> _decodeJson(String jsonString) =>
      jsonDecode(jsonString) as Map<String, dynamic>;

  KnowledgeBaseRoadmapData _mapRoadmap(Map<String, dynamic> json) {
    final initiallyCollapsed =
        ((json['initiallyCollapsed'] as List<dynamic>? ?? const <dynamic>[])
            .map((item) => item as String)
            .toList(growable: false));

    final nodes = <String, KnowledgeBaseRoadmapNode>{};

    final rootJson = json['root'];
    if (rootJson is! Map<String, dynamic>) {
      throw const FormatException('Roadmap JSON must contain a "root" object.');
    }
    final rootId = _collectNodesRecursively(rootJson, nodes, isRoot: true);

    return KnowledgeBaseRoadmapData(
      rootId: rootId,
      nodes: nodes,
      initiallyCollapsedNodeIds: initiallyCollapsed,
    );
  }

  String _collectNodesRecursively(
    Map<String, dynamic> nodeJson,
    Map<String, KnowledgeBaseRoadmapNode> nodes, {
    bool isRoot = false,
  }) {
    final id = nodeJson['id'] as String;
    final title = nodeJson['title'] as String;
    final subtitle = nodeJson['subtitle'] as String;
    final descriptionMarkdown = nodeJson['descriptionMarkdown'] as String;
    final accentHex = nodeJson['accentHex'] as String;
    final kind = _parseKind(nodeJson['kind'], isRoot: isRoot);
    final childrenJson = nodeJson['children'] as List<dynamic>? ?? const [];

    final childIds = <String>[];
    for (final child in childrenJson) {
      if (child is Map<String, dynamic>) {
        final childId = _collectNodesRecursively(child, nodes);
        childIds.add(childId);
      }
    }

    nodes[id] = KnowledgeBaseRoadmapNode(
      id: id,
      kind: kind,
      title: title,
      subtitle: subtitle,
      descriptionMarkdown: descriptionMarkdown,
      accentHex: accentHex,
      children: childIds,
    );
    return id;
  }

  KnowledgeBaseRoadmapNodeKind _parseKind(
    dynamic value, {
    required bool isRoot,
  }) {
    if (value is String) {
      return KnowledgeBaseRoadmapNodeKind.values.firstWhere(
        (e) => e.name == value,
        orElse: () => KnowledgeBaseRoadmapNodeKind.topic,
      );
    }
    if (isRoot) {
      return KnowledgeBaseRoadmapNodeKind.root;
    }
    return KnowledgeBaseRoadmapNodeKind.topic;
  }
}
