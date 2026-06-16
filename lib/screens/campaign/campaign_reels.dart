import 'package:flutter/material.dart';
import 'package:plasess/screens/campaign/campaign_api.dart';
import 'package:plasess/screens/campaign/campaign_model.dart';
import 'package:plasess/screens/campaign/pyemnt_bootom_sheet.dart';

class CampaignReelsPage extends StatefulWidget {
  const CampaignReelsPage({super.key});

  @override
  State<CampaignReelsPage> createState() => _CampaignReelsPageState();
}

class _CampaignReelsPageState extends State<CampaignReelsPage> {
  final CampaignApi campaignApi = CampaignApi();

  List<CampaaignModel> campaigns = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCampaigns();
  }

  Future<void> loadCampaigns() async {
    // استبدلها بالـ API تبعتك
    campaigns = await campaignApi.getAllCampaigns();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          final campaign = campaigns[index];
          // حساب نسبة الإنجاز
          final double progress = campaign.targetAmount == 0
              ? 0
              : (campaign.collectedAmount / campaign.targetAmount).clamp(
                  0.0,
                  1.0,
                );

          return Stack(
            fit: StackFit.expand,
            children: [
              /// صورة الحملة
              Image.network(campaign.imageUrl, fit: BoxFit.cover),

              /// طبقة شفافة فوق الصورة
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(50),
                      Colors.black.withAlpha(230),
                    ],
                  ),
                ),
              ),

              /// معلومات الحملة
              Positioned(
                left: 20,
                right: 20,
                bottom: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// العنوان
                    Text(
                      campaign.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// الوصف
                    Text(
                      campaign.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// عدد المتبرعين
                    Row(
                      children: [
                        const Icon(Icons.people, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          "${campaign.donorCount} donors",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    /// المبلغ
                    Text(
                      "${campaign.collectedAmount.toInt()} / ${campaign.targetAmount.toInt()} JOD",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // نسبة الإنجاز
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      "${(progress * 100).toStringAsFixed(0)}% completed",
                      style: const TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 20),

                    /// زر التبرع
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: campaign.isActive
                            ? () {
                                showDonateBottomSheet(
                                  context,
                                  campaign,
                                  () async {
                                    await loadCampaigns();
                                  },
                                );
                              }
                            : null,
                        child: Text(
                          campaign.isActive
                              ? "Donate Now"
                              : "Campaign Completed",
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// تاريخ الانتهاء
                    Text(
                      "Ends: ${campaign.endDate.toString().split(' ')[0]}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
