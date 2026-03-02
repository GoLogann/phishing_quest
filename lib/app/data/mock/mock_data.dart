import 'package:phishing_quest/app/data/enumerators/difficulty.enum.dart';
import 'package:phishing_quest/app/data/enumerators/user_role.enum.dart';
import 'package:phishing_quest/app/data/models/answer.model.dart';
import 'package:phishing_quest/app/data/models/answer_result.model.dart';
import 'package:phishing_quest/app/data/models/category.model.dart';
import 'package:phishing_quest/app/data/models/phishing_email.model.dart';
import 'package:phishing_quest/app/data/models/question.model.dart';
import 'package:phishing_quest/app/data/models/ranking_entry.model.dart';
import 'package:phishing_quest/app/data/models/user.model.dart';
import 'package:phishing_quest/app/data/models/user_stats.model.dart';

class MockData {
  MockData._();

  // ==================== CATEGORIES ====================
  static final List<CategoryModel> categories = [
    CategoryModel(
      id: 'cat-001',
      categoryName: 'Phishing Corporativo',
      description: 'Emails falsos que imitam comunicações empresariais',
      icon: '🏢',
      questionCount: 4,
    ),
    CategoryModel(
      id: 'cat-002',
      categoryName: 'Engenharia Social',
      description: 'Técnicas de manipulação psicológica para obter informações',
      icon: '🧠',
      questionCount: 3,
    ),
    CategoryModel(
      id: 'cat-003',
      categoryName: 'Segurança Digital',
      description: 'Práticas e conceitos de segurança da informação',
      icon: '🔒',
      questionCount: 3,
    ),
  ];

  // ==================== PHISHING EMAILS ====================
  static final List<PhishingEmailModel> phishingEmails = [
    PhishingEmailModel(
      id: 'pe-001',
      questionId: 'q-001',
      phishforgeId: 'pf-001',
      receptor: 'joao.silva@empresa.com',
      remetente: 'ti-suporte@empres4.net',
      assunto: 'URGENTE: Atualização de Sistema Obrigatória',
      conteudo: '''Prezado colaborador,

Identificamos que sua estação de trabalho está com uma vulnerabilidade crítica de segurança. É necessário realizar uma atualização imediata do sistema.

Para iniciar a atualização, clique no link abaixo e insira suas credenciais corporativas:

http://empres4.net/sistema/atualizar

ATENÇÃO: Esta atualização deve ser realizada em até 2 horas para evitar o bloqueio de seu acesso ao sistema.

Atenciosamente,
Equipe de Suporte TI''',
      explicacao: 'Este email utiliza táticas de urgência e typosquatting (empres4.net em vez de empresa.net) para enganar o destinatário. O link leva a um domínio falso que coleta credenciais.',
      nivel: 'medium',
      categoria: 'corporativo',
      links: ['http://empres4.net/sistema/atualizar'],
    ),
    PhishingEmailModel(
      id: 'pe-002',
      questionId: 'q-002',
      phishforgeId: 'pf-002',
      receptor: 'maria.santos@empresa.com',
      remetente: 'rh@empresa-br.com',
      assunto: 'Bônus Salarial - Confirmação Necessária',
      conteudo: '''Prezada Maria,

Informamos que você foi selecionada para receber um bônus salarial de R\$ 2.500,00 referente ao seu desempenho no último trimestre.

Para confirmar o recebimento, acesse o portal de RH e valide seus dados bancários:

https://empresa-br.com/rh/bonus-validacao

Prazo: 24 horas para confirmação.

Departamento de Recursos Humanos
Empresa Brasil S.A.''',
      explicacao: 'Email clássico de phishing usando isca financeira. O domínio "empresa-br.com" é falso (não é o domínio real da empresa). A urgência de 24h pressiona a vítima a agir sem pensar.',
      nivel: 'easy',
      categoria: 'corporativo',
      links: ['https://empresa-br.com/rh/bonus-validacao'],
    ),
    PhishingEmailModel(
      id: 'pe-003',
      questionId: 'q-003',
      phishforgeId: 'pf-003',
      receptor: 'carlos.oliveira@techcorp.com',
      remetente: 'security-alert@micr0soft.com',
      assunto: 'Alerta de Segurança: Atividade Suspeita Detectada',
      conteudo: '''Alerta de Segurança Microsoft

Detectamos uma tentativa de acesso não autorizado à sua conta Microsoft 365 a partir de um dispositivo não reconhecido.

Localização: Moscou, Rússia
Horário: 03:24 AM (horário local)
Dispositivo: Linux Desktop

Se você NÃO reconhece esta atividade, clique imediatamente no botão abaixo para proteger sua conta:

[PROTEGER MINHA CONTA]
https://micr0soft.com/security/verify

Se foi você, ignore este email.

Equipe de Segurança Microsoft''',
      explicacao: 'Phishing sofisticado que imita alertas reais da Microsoft. Usa typosquatting sutil (micr0soft com zero). A narrativa de "ataque de Moscou" cria medo e urgência. Note que Microsoft real nunca usa esse tipo de domínio.',
      nivel: 'hard',
      categoria: 'corporativo',
      links: ['https://micr0soft.com/security/verify'],
    ),
    PhishingEmailModel(
      id: 'pe-004',
      questionId: 'q-004',
      phishforgeId: 'pf-004',
      receptor: 'ana.costa@empresa.com',
      remetente: 'suporte@banc0dobrasil.com',
      assunto: 'Seu token de acesso expirou',
      conteudo: '''Banco do Brasil Informa

Prezado(a) cliente,

Seu token de segurança para acesso ao Internet Banking expirou e precisa ser renovado.

Clique abaixo para renovar seu token gratuitamente:

https://banc0dobrasil.com/renovar-token

Caso não renove em 48 horas, seu acesso será bloqueado por medida de segurança.

Central de Atendimento
Banco do Brasil''',
      explicacao: 'Phishing bancário clássico. O domínio usa "banc0" (com zero) em vez de "banco". Bancos nunca pedem renovação de token por email. A ameaça de bloqueio é tática de pressão.',
      nivel: 'easy',
      categoria: 'corporativo',
      links: ['https://banc0dobrasil.com/renovar-token'],
    ),
  ];

  // ==================== QUESTIONS ====================
  static final List<QuestionModel> questions = [
    // Phishing Corporativo
    QuestionModel(
      id: 'q-001',
      questionText: 'Analise o email abaixo e determine se é um email legítimo ou uma tentativa de phishing.',
      categoryId: 'cat-001',
      difficulty: Difficulty.medium,
      phishingEmailId: 'pe-001',
    ),
    QuestionModel(
      id: 'q-002',
      questionText: 'Você recebeu este email no trabalho. Qual é a sua avaliação?',
      categoryId: 'cat-001',
      difficulty: Difficulty.easy,
      phishingEmailId: 'pe-002',
    ),
    QuestionModel(
      id: 'q-003',
      questionText: 'Este alerta de segurança chegou ao seu email corporativo. Analise os detalhes e determine sua autenticidade.',
      categoryId: 'cat-001',
      difficulty: Difficulty.hard,
      phishingEmailId: 'pe-003',
    ),
    QuestionModel(
      id: 'q-004',
      questionText: 'Você recebeu esta mensagem do seu banco. Ela é confiável?',
      categoryId: 'cat-001',
      difficulty: Difficulty.easy,
      phishingEmailId: 'pe-004',
    ),
    // Engenharia Social
    QuestionModel(
      id: 'q-005',
      questionText: 'Qual das seguintes é uma técnica comum de engenharia social?',
      categoryId: 'cat-002',
      difficulty: Difficulty.easy,
    ),
    QuestionModel(
      id: 'q-006',
      questionText: 'Um colega de trabalho pede sua senha para "resolver um problema urgente". O que você deve fazer?',
      categoryId: 'cat-002',
      difficulty: Difficulty.medium,
    ),
    QuestionModel(
      id: 'q-007',
      questionText: 'Você recebe uma ligação de alguém dizendo ser do suporte técnico pedindo acesso remoto ao seu computador. Qual é a melhor ação?',
      categoryId: 'cat-002',
      difficulty: Difficulty.medium,
    ),
    // Segurança Digital
    QuestionModel(
      id: 'q-008',
      questionText: 'Qual é a prática mais segura para criação de senhas?',
      categoryId: 'cat-003',
      difficulty: Difficulty.easy,
    ),
    QuestionModel(
      id: 'q-009',
      questionText: 'O que é autenticação de dois fatores (2FA)?',
      categoryId: 'cat-003',
      difficulty: Difficulty.medium,
    ),
    QuestionModel(
      id: 'q-010',
      questionText: 'Qual protocolo indica que um site é seguro para transações?',
      categoryId: 'cat-003',
      difficulty: Difficulty.easy,
    ),
  ];

  // ==================== ANSWERS ====================
  static final Map<String, List<AnswerModel>> answersByQuestion = {
    'q-001': [
      AnswerModel(id: 'a-001', questionId: 'q-001', answerText: 'É um email legítimo de TI — devo atualizar imediatamente', isCorrect: false),
      AnswerModel(id: 'a-002', questionId: 'q-001', answerText: 'É phishing — o domínio do remetente é suspeito e usa urgência', isCorrect: true),
      AnswerModel(id: 'a-003', questionId: 'q-001', answerText: 'Não tenho certeza — vou clicar para ver se é real', isCorrect: false),
      AnswerModel(id: 'a-004', questionId: 'q-001', answerText: 'É spam comum — posso ignorar sem preocupação', isCorrect: false),
    ],
    'q-002': [
      AnswerModel(id: 'a-005', questionId: 'q-002', answerText: 'Legítimo — vou confirmar o bônus', isCorrect: false),
      AnswerModel(id: 'a-006', questionId: 'q-002', answerText: 'Phishing — isca financeira com domínio falso', isCorrect: true),
      AnswerModel(id: 'a-007', questionId: 'q-002', answerText: 'Vou reencaminhar para colegas', isCorrect: false),
      AnswerModel(id: 'a-008', questionId: 'q-002', answerText: 'Pode ser vírus — vou deletar sem analisar', isCorrect: false),
    ],
    'q-003': [
      AnswerModel(id: 'a-009', questionId: 'q-003', answerText: 'É legítimo — Microsoft sempre envia esses alertas', isCorrect: false),
      AnswerModel(id: 'a-010', questionId: 'q-003', answerText: 'É phishing — typosquatting no domínio e criação de pânico', isCorrect: true),
      AnswerModel(id: 'a-011', questionId: 'q-003', answerText: 'Vou clicar para verificar — melhor prevenir', isCorrect: false),
      AnswerModel(id: 'a-012', questionId: 'q-003', answerText: 'Parece legítimo mas vou ignorar mesmo assim', isCorrect: false),
    ],
    'q-004': [
      AnswerModel(id: 'a-013', questionId: 'q-004', answerText: 'Sim, é do Banco do Brasil — devo renovar o token', isCorrect: false),
      AnswerModel(id: 'a-014', questionId: 'q-004', answerText: 'Não — é phishing, o domínio usa zero no lugar de "o"', isCorrect: true),
      AnswerModel(id: 'a-015', questionId: 'q-004', answerText: 'Talvez — vou ligar para o banco antes', isCorrect: false),
      AnswerModel(id: 'a-016', questionId: 'q-004', answerText: 'Sim, bancos sempre enviam emails assim', isCorrect: false),
    ],
    'q-005': [
      AnswerModel(id: 'a-017', questionId: 'q-005', answerText: 'Pretexting — criar um cenário falso para obter informações', isCorrect: true),
      AnswerModel(id: 'a-018', questionId: 'q-005', answerText: 'Firewall — barreira de proteção de rede', isCorrect: false),
      AnswerModel(id: 'a-019', questionId: 'q-005', answerText: 'Criptografia — codificação de dados', isCorrect: false),
      AnswerModel(id: 'a-020', questionId: 'q-005', answerText: 'Backup — cópia de segurança de dados', isCorrect: false),
    ],
    'q-006': [
      AnswerModel(id: 'a-021', questionId: 'q-006', answerText: 'Dar a senha — ele é de confiança', isCorrect: false),
      AnswerModel(id: 'a-022', questionId: 'q-006', answerText: 'Recusar e reportar ao setor de segurança', isCorrect: true),
      AnswerModel(id: 'a-023', questionId: 'q-006', answerText: 'Dar apenas metade da senha', isCorrect: false),
      AnswerModel(id: 'a-024', questionId: 'q-006', answerText: 'Enviar por email para ter registro', isCorrect: false),
    ],
    'q-007': [
      AnswerModel(id: 'a-025', questionId: 'q-007', answerText: 'Dar acesso — podem resolver o problema', isCorrect: false),
      AnswerModel(id: 'a-026', questionId: 'q-007', answerText: 'Pedir para enviar um email oficial e verificar', isCorrect: false),
      AnswerModel(id: 'a-027', questionId: 'q-007', answerText: 'Desligar, ligar diretamente para o suporte oficial da empresa e reportar', isCorrect: true),
      AnswerModel(id: 'a-028', questionId: 'q-007', answerText: 'Dar acesso mas ficar assistindo', isCorrect: false),
    ],
    'q-008': [
      AnswerModel(id: 'a-029', questionId: 'q-008', answerText: 'Usar o nome do pet como senha', isCorrect: false),
      AnswerModel(id: 'a-030', questionId: 'q-008', answerText: 'Usar "123456" — fácil de lembrar', isCorrect: false),
      AnswerModel(id: 'a-031', questionId: 'q-008', answerText: 'Criar senhas longas com letras, números e símbolos, diferentes para cada conta', isCorrect: true),
      AnswerModel(id: 'a-032', questionId: 'q-008', answerText: 'Anotar a senha em um papel na mesa', isCorrect: false),
    ],
    'q-009': [
      AnswerModel(id: 'a-033', questionId: 'q-009', answerText: 'Usar duas senhas diferentes', isCorrect: false),
      AnswerModel(id: 'a-034', questionId: 'q-009', answerText: 'Um método que exige dois tipos de verificação para confirmar identidade', isCorrect: true),
      AnswerModel(id: 'a-035', questionId: 'q-009', answerText: 'Ter duas contas de email', isCorrect: false),
      AnswerModel(id: 'a-036', questionId: 'q-009', answerText: 'Compartilhar senha com duas pessoas', isCorrect: false),
    ],
    'q-010': [
      AnswerModel(id: 'a-037', questionId: 'q-010', answerText: 'HTTP', isCorrect: false),
      AnswerModel(id: 'a-038', questionId: 'q-010', answerText: 'FTP', isCorrect: false),
      AnswerModel(id: 'a-039', questionId: 'q-010', answerText: 'HTTPS', isCorrect: true),
      AnswerModel(id: 'a-040', questionId: 'q-010', answerText: 'SMTP', isCorrect: false),
    ],
  };

  // ==================== RANKING ====================
  static final List<RankingEntryModel> ranking = [
    RankingEntryModel(userId: 'u-001', username: 'CyberNinja', score: 2450, position: 1, totalAnswered: 120, totalCorrect: 108),
    RankingEntryModel(userId: 'u-002', username: 'PhishHunter', score: 2280, position: 2, totalAnswered: 115, totalCorrect: 98),
    RankingEntryModel(userId: 'u-003', username: 'SecureMaster', score: 2100, position: 3, totalAnswered: 110, totalCorrect: 95),
    RankingEntryModel(userId: 'u-004', username: 'HackShield', score: 1950, position: 4, totalAnswered: 105, totalCorrect: 88),
    RankingEntryModel(userId: 'u-005', username: 'DataGuard', score: 1820, position: 5, totalAnswered: 100, totalCorrect: 82),
    RankingEntryModel(userId: 'u-006', username: 'FirewallPro', score: 1750, position: 6, totalAnswered: 98, totalCorrect: 79),
    RankingEntryModel(userId: 'u-007', username: 'ByteDefender', score: 1680, position: 7, totalAnswered: 95, totalCorrect: 76),
    RankingEntryModel(userId: 'u-008', username: 'NetWatcher', score: 1590, position: 8, totalAnswered: 90, totalCorrect: 70),
    RankingEntryModel(userId: 'u-009', username: 'CryptoKnight', score: 1520, position: 9, totalAnswered: 88, totalCorrect: 68),
    RankingEntryModel(userId: 'u-010', username: 'VirusSlayer', score: 1450, position: 10, totalAnswered: 85, totalCorrect: 65),
    RankingEntryModel(userId: 'u-011', username: 'ThreatSeeker', score: 1380, position: 11, totalAnswered: 80, totalCorrect: 62),
    RankingEntryModel(userId: 'u-012', username: 'CodeSentinel', score: 1290, position: 12, totalAnswered: 78, totalCorrect: 58),
    RankingEntryModel(userId: 'u-013', username: 'ShieldWall', score: 1200, position: 13, totalAnswered: 75, totalCorrect: 55),
    RankingEntryModel(userId: 'u-014', username: 'ZeroDay', score: 1150, position: 14, totalAnswered: 70, totalCorrect: 52),
    RankingEntryModel(userId: 'u-015', username: 'PixelGuard', score: 1080, position: 15, totalAnswered: 68, totalCorrect: 48),
    RankingEntryModel(userId: 'u-016', username: 'SafeNet', score: 980, position: 16, totalAnswered: 65, totalCorrect: 45),
    RankingEntryModel(userId: 'u-017', username: 'BugBounty', score: 920, position: 17, totalAnswered: 60, totalCorrect: 42),
    RankingEntryModel(userId: 'u-018', username: 'PenTester', score: 850, position: 18, totalAnswered: 58, totalCorrect: 39),
    RankingEntryModel(userId: 'u-019', username: 'LogAnalyst', score: 780, position: 19, totalAnswered: 55, totalCorrect: 36),
    RankingEntryModel(userId: 'u-020', username: 'RookieHacker', score: 650, position: 20, totalAnswered: 50, totalCorrect: 30),
  ];

  // ==================== USER STATS ====================
  static UserStatsModel get userStats => UserStatsModel(
    totalAnswered: 45,
    totalCorrect: 36,
    averageAiRating: 3.8,
    byDifficulty: {
      'easy': DifficultyStats(answered: 20, correct: 18),
      'medium': DifficultyStats(answered: 15, correct: 11),
      'hard': DifficultyStats(answered: 10, correct: 7),
    },
    byCategory: {
      'cat-001': CategoryStats(categoryName: 'Phishing Corporativo', answered: 20, correct: 16),
      'cat-002': CategoryStats(categoryName: 'Engenharia Social', answered: 13, correct: 10),
      'cat-003': CategoryStats(categoryName: 'Segurança Digital', answered: 12, correct: 10),
    },
    scoreHistory: [
      ScoreHistoryEntry(date: DateTime(2026, 1, 1), score: 100),
      ScoreHistoryEntry(date: DateTime(2026, 1, 8), score: 280),
      ScoreHistoryEntry(date: DateTime(2026, 1, 15), score: 450),
      ScoreHistoryEntry(date: DateTime(2026, 1, 22), score: 620),
      ScoreHistoryEntry(date: DateTime(2026, 2, 1), score: 800),
      ScoreHistoryEntry(date: DateTime(2026, 2, 8), score: 950),
      ScoreHistoryEntry(date: DateTime(2026, 2, 15), score: 1100),
      ScoreHistoryEntry(date: DateTime(2026, 2, 22), score: 1280),
      ScoreHistoryEntry(date: DateTime(2026, 3, 1), score: 1450),
    ],
  );

  // ==================== MOCK AI FEEDBACK ====================
  static AnswerResultModel mockCorrectWithAI() => AnswerResultModel(
    isCorrect: true,
    message: 'Excelente análise! Você demonstrou bom entendimento sobre phishing.',
    aiRating: 4,
    feedback: 'Boa análise! Você identificou corretamente os indicadores principais de phishing neste email.',
    strengths: [
      'Identificou typosquatting no domínio',
      'Reconheceu tática de urgência como sinal de alerta',
      'Analisou o link suspeito',
    ],
    improvements: [
      'Mencionar a falta de personalização (ausência de nome)',
      'Identificar solicitação implícita de credenciais',
    ],
    points: 15,
  );

  static AnswerResultModel mockIncorrect() => AnswerResultModel(
    isCorrect: false,
    message: 'Resposta incorreta. Veja a explicação para entender melhor.',
    aiRating: null,
    feedback: null,
    points: 0,
  );

  // ==================== MOCK USER ====================
  static UserModel get currentUser => UserModel(
    id: 'u-current',
    username: 'Jogador',
    email: 'jogador@teste.com',
    role: UserRole.player,
    score: 1450,
    createdAt: DateTime(2026, 1, 1),
  );

  static UserModel get adminUser => UserModel(
    id: 'u-admin',
    username: 'Admin',
    email: 'admin@phishingquest.com',
    role: UserRole.admin,
    score: 0,
    createdAt: DateTime(2025, 6, 1),
  );
}
