import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/inbox_email.model.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

class EmailSimController extends GetxController {
  final RxList<InboxEmailModel> inboxEmails = <InboxEmailModel>[].obs;
  final RxBool isLoading = true.obs;

  // Per-email tracking
  final RxMap<String, bool> userVerdicts = <String, bool>{}.obs;
  final RxMap<String, String> userJustifications = <String, String>{}.obs;
  final RxMap<String, bool> clickedLinks = <String, bool>{}.obs;
  final RxMap<String, bool> verdictCorrect = <String, bool>{}.obs;

  final RxInt totalScore = 0.obs;

  int get evaluatedCount => userVerdicts.length;
  bool get allEvaluated => evaluatedCount >= inboxEmails.length;

  @override
  void onInit() {
    super.onInit();
    loadEmails();
  }

  Future<void> loadEmails() async {
    isLoading.value = true;
    try {
      inboxEmails.value = MockData.simulationInbox;
    } catch (_) {
      inboxEmails.value = MockData.simulationInbox;
    }
    isLoading.value = false;
  }

  void onLinkTapped(String emailId, String url) {
    final email = inboxEmails.firstWhereOrNull((e) => e.id == emailId);
    if (email != null && email.isPhishing) {
      clickedLinks[emailId] = true;
    }
  }

  bool isEmailEvaluated(String emailId) => userVerdicts.containsKey(emailId);

  bool? wasCorrect(String emailId) => verdictCorrect[emailId];

  void submitVerdict(String emailId, bool saysPhishing, String justification) {
    final email = inboxEmails.firstWhereOrNull((e) => e.id == emailId);
    if (email == null) return;

    userVerdicts[emailId] = saysPhishing;
    userJustifications[emailId] = justification;

    final isCorrect = saysPhishing == email.isPhishing;
    verdictCorrect[emailId] = isCorrect;

    // Pontuacao
    int points = isCorrect ? 15 : 5;
    if (clickedLinks.containsKey(emailId)) {
      points -= 5;
    }
    totalScore.value += points;
  }

  void finishSimulation() {
    Get.toNamed('/email-sim/result', arguments: {
      'emails': inboxEmails.toList(),
      'verdicts': Map<String, bool>.from(userVerdicts),
      'justifications': Map<String, String>.from(userJustifications),
      'clickedLinks': Map<String, bool>.from(clickedLinks),
      'verdictCorrect': Map<String, bool>.from(verdictCorrect),
      'totalScore': totalScore.value,
    });
  }

  void showVerdictSheet(BuildContext context, InboxEmailModel email) {
    final justController = TextEditingController();
    final selectedVerdict = Rx<bool?>(null);

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: AppTheme.colors.backgroundCard,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppTheme.colors.surfaceBorder,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Este email e phishing?',
              style: AppTheme.textStyles.title.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20.h),
            Obx(() => Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => selectedVerdict.value = true,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: selectedVerdict.value == true
                            ? AppTheme.colors.error.withOpacity(0.2)
                            : AppTheme.colors.backgroundDark,
                        border: Border.all(
                          color: selectedVerdict.value == true
                              ? AppTheme.colors.error
                              : AppTheme.colors.surfaceBorder,
                          width: selectedVerdict.value == true ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.warning_rounded,
                              color: selectedVerdict.value == true
                                  ? AppTheme.colors.error
                                  : AppTheme.colors.textMuted,
                              size: 28.sp),
                          SizedBox(height: 6.h),
                          Text(
                            'Sim, e phishing',
                            style: AppTheme.textStyles.label.copyWith(
                              color: selectedVerdict.value == true
                                  ? AppTheme.colors.error
                                  : AppTheme.colors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () => selectedVerdict.value = false,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: selectedVerdict.value == false
                            ? AppTheme.colors.success.withOpacity(0.2)
                            : AppTheme.colors.backgroundDark,
                        border: Border.all(
                          color: selectedVerdict.value == false
                              ? AppTheme.colors.success
                              : AppTheme.colors.surfaceBorder,
                          width: selectedVerdict.value == false ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.verified_user_rounded,
                              color: selectedVerdict.value == false
                                  ? AppTheme.colors.success
                                  : AppTheme.colors.textMuted,
                              size: 28.sp),
                          SizedBox(height: 6.h),
                          Text(
                            'Nao, e legitimo',
                            style: AppTheme.textStyles.label.copyWith(
                              color: selectedVerdict.value == false
                                  ? AppTheme.colors.success
                                  : AppTheme.colors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(height: 16.h),
            TextField(
              controller: justController,
              maxLines: 3,
              style: AppTheme.textStyles.posLabel,
              decoration: InputDecoration(
                hintText: 'Justifique sua resposta...',
                hintStyle: AppTheme.textStyles.label.copyWith(color: AppTheme.colors.textMuted),
                filled: true,
                fillColor: AppTheme.colors.backgroundDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(() {
              final hasVerdict = selectedVerdict.value != null;
              return GestureDetector(
                onTap: hasVerdict
                    ? () {
                        submitVerdict(email.id, selectedVerdict.value!, justController.text);
                        Get.back();
                        _showVerdictResult(email);
                      }
                    : null,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    gradient: hasVerdict
                        ? LinearGradient(colors: [
                            AppTheme.colors.primary,
                            AppTheme.colors.primary.withOpacity(0.8),
                          ])
                        : null,
                    color: hasVerdict ? null : AppTheme.colors.surfaceBorder,
                  ),
                  child: Center(
                    child: Text(
                      'Confirmar',
                      style: AppTheme.textStyles.subTitle.copyWith(
                        color: hasVerdict ? Colors.white : AppTheme.colors.textMuted,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _showVerdictResult(InboxEmailModel email) {
    final isCorrect = verdictCorrect[email.id] ?? false;
    final didClickLink = clickedLinks.containsKey(email.id);

    Get.dialog(
      Dialog(
        backgroundColor: AppTheme.colors.backgroundCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: isCorrect ? AppTheme.colors.success : AppTheme.colors.error,
                size: 64.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                isCorrect ? 'Correto!' : 'Incorreto!',
                style: AppTheme.textStyles.title.copyWith(
                  color: isCorrect ? AppTheme.colors.success : AppTheme.colors.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                email.isPhishing ? 'Este email ERA phishing.' : 'Este email era LEGITIMO.',
                style: AppTheme.textStyles.posLabel.copyWith(
                  color: AppTheme.colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: AppTheme.colors.backgroundDark,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explicacao:',
                      style: AppTheme.textStyles.label.copyWith(
                        color: AppTheme.colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      email.explicacao,
                      style: AppTheme.textStyles.label.copyWith(
                        color: AppTheme.colors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (didClickLink) ...[
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppTheme.colors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppTheme.colors.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.link_off, color: AppTheme.colors.error, size: 18.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Voce clicou em um link suspeito! -5 pts',
                          style: AppTheme.textStyles.label.copyWith(
                            color: AppTheme.colors.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: AppTheme.colors.primary,
                  ),
                  child: Center(
                    child: Text(
                      'Voltar para Caixa de Entrada',
                      style: AppTheme.textStyles.posLabel.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
