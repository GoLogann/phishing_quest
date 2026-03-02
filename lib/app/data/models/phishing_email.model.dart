class PhishingEmailModel {
  final String id;
  final String questionId;
  final String phishforgeId;
  final String receptor;
  final String remetente;
  final String assunto;
  final String conteudo;
  final String explicacao;
  final String nivel;
  final String categoria;
  final List<String> links;

  PhishingEmailModel({
    required this.id,
    required this.questionId,
    required this.phishforgeId,
    required this.receptor,
    required this.remetente,
    required this.assunto,
    required this.conteudo,
    required this.explicacao,
    required this.nivel,
    required this.categoria,
    required this.links,
  });

  factory PhishingEmailModel.fromJson(Map<String, dynamic> json) {
    return PhishingEmailModel(
      id: json['id'] ?? json['phishingEmailId'] ?? '',
      questionId: json['questionId'] ?? json['question_id'] ?? '',
      phishforgeId: json['phishforgeId'] ?? json['phishforge_id'] ?? '',
      receptor: json['receptor'] ?? '',
      remetente: json['remetente'] ?? '',
      assunto: json['assunto'] ?? '',
      conteudo: json['conteudo'] ?? '',
      explicacao: json['explicacao'] ?? '',
      nivel: json['nivel'] ?? '',
      categoria: json['categoria'] ?? '',
      links: json['links'] != null ? List<String>.from(json['links']) : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'questionId': questionId,
    'phishforgeId': phishforgeId,
    'receptor': receptor,
    'remetente': remetente,
    'assunto': assunto,
    'conteudo': conteudo,
    'explicacao': explicacao,
    'nivel': nivel,
    'categoria': categoria,
    'links': links,
  };
}
