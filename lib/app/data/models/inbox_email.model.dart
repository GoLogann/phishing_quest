import 'package:phishing_quest/app/data/models/phishing_email.model.dart';

class InboxEmailModel {
  final String id;
  final String receptor;
  final String remetente;
  final String remetenteNome;
  final String assunto;
  final String conteudo;
  final List<String> links;
  final bool isPhishing;
  final String explicacao;
  final String nivel;
  final String categoria;
  final DateTime receivedAt;
  final bool hasAttachment;

  InboxEmailModel({
    required this.id,
    required this.receptor,
    required this.remetente,
    required this.remetenteNome,
    required this.assunto,
    required this.conteudo,
    this.links = const [],
    required this.isPhishing,
    required this.explicacao,
    required this.nivel,
    required this.categoria,
    required this.receivedAt,
    this.hasAttachment = false,
  });

  String get avatarInitial => remetenteNome.isNotEmpty
      ? remetenteNome[0].toUpperCase()
      : remetente[0].toUpperCase();

  String get preview {
    final clean = conteudo.replaceAll('\n', ' ').trim();
    return clean.length > 80 ? '${clean.substring(0, 80)}...' : clean;
  }

  factory InboxEmailModel.fromPhishingEmail(PhishingEmailModel pe, {DateTime? receivedAt}) {
    final nome = _extractName(pe.remetente);
    return InboxEmailModel(
      id: pe.id,
      receptor: pe.receptor,
      remetente: pe.remetente,
      remetenteNome: nome,
      assunto: pe.assunto,
      conteudo: pe.conteudo,
      links: pe.links,
      isPhishing: true,
      explicacao: pe.explicacao,
      nivel: pe.nivel,
      categoria: pe.categoria,
      receivedAt: receivedAt ?? DateTime.now().subtract(const Duration(hours: 2)),
    );
  }

  factory InboxEmailModel.fromJson(Map<String, dynamic> json) {
    return InboxEmailModel(
      id: json['id'] ?? json['phishingEmailId'] ?? '',
      receptor: json['receptor'] ?? '',
      remetente: json['remetente'] ?? '',
      remetenteNome: json['remetenteNome'] ?? _extractName(json['remetente'] ?? ''),
      assunto: json['assunto'] ?? '',
      conteudo: json['conteudo'] ?? '',
      links: json['links'] != null ? List<String>.from(json['links']) : [],
      isPhishing: json['isPhishing'] ?? true,
      explicacao: json['explicacao'] ?? '',
      nivel: json['nivel'] ?? 'medium',
      categoria: json['categoria'] ?? '',
      receivedAt: json['receivedAt'] != null
          ? DateTime.parse(json['receivedAt'])
          : DateTime.now(),
      hasAttachment: json['hasAttachment'] ?? false,
    );
  }

  static String _extractName(String email) {
    final parts = email.split('@');
    if (parts.isEmpty) return '';
    return parts[0]
        .replaceAll(RegExp(r'[._-]'), ' ')
        .split(' ')
        .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
        .join(' ');
  }
}
