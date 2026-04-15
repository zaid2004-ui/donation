import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plasess/screens/campaign/campaign_api.dart';
import 'package:plasess/screens/campaign/campaign_model.dart';

class Campain extends StatefulWidget {
  const Campain({
    super.key,
    required this.name,
    required this.description,
    required this.donationNumber,
    required this.instatiosnId,
  });
  final String name;
  final String description;
  final String donationNumber;
  final String instatiosnId;

  @override
  State<Campain> createState() => _CampainState();
}

class _CampainState extends State<Campain> {
  final campaignApi = CampaignApi();
  List<CampaaignModel> campaignsList = [];
  Future<void> getCampaigns(String instatiosnId) async {
    campaignsList = await campaignApi.getCampaigns(instatiosnId);
    setState(() {});
    log(
      'Fetched ${campaignsList.length} campaigns for instatiosnId: $instatiosnId',
    );
  }

  @override
  void initState() {
    getCampaigns(widget.instatiosnId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: ListView(
        children: [
          // Institution Info
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Image.asset('assets/images/logo.png', width: 100, height: 100),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Donation Number: ${widget.donationNumber}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: campaignsList.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        "Title: ${campaignsList[index].title}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      const SizedBox(height: 10),

                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          campaignsList[index].imageUrl,
                          width: 50,
                          height: 50,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Description
                      Text(
                        "Description: ${campaignsList[index].description}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      const SizedBox(height: 8),

                      // Donation Number
                      Text(
                        "Donation Number: ${campaignsList[index].targetAmount}",
                      ),

                      const SizedBox(height: 8),

                      // Target Amount
                      Text(
                        "Target Amount: ${campaignsList[index].targetAmount}",
                      ),

                      const SizedBox(height: 8),

                      // Dates
                      Text(campaignsList[index].startDate.toString()),
                      Text(
                        "End Date: ${campaignsList[index].endDate.toString()}",
                      ),

                      const SizedBox(height: 8),

                      // Status
                      Row(
                        children: const [
                          Text("Status: "),
                          Text("Inactive", style: TextStyle(color: Colors.red)),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // IDs (خفيفة بالآخر)
                      Text("Campaign ID: ${campaignsList[index].campaignId}"),
                      Text("Category ID: ${campaignsList[index].categoryId}"),
                      Text(
                        "Institution ID: ${campaignsList[index].institutionId}",
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
