import 'package:flutter/material.dart';
import 'package:plasess/screens/Donation_process/donation_api.dart';
import 'package:plasess/screens/Donation_process/donation_model.dart';

class AllDonations extends StatefulWidget {
  const AllDonations({super.key});

  @override
  State<AllDonations> createState() => _AllDonationsState();
}

class _AllDonationsState extends State<AllDonations> {
  final DonationApi donationApi = DonationApi();
  late Future<List<DonationModel>> donationsFuture;

  @override
  void initState() {
    super.initState();
    donationsFuture = donationApi.getAllDonations();
  }

  Future<void> refresh() async {
    setState(() {
      donationsFuture = donationApi.getAllDonations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("كل التبرعات")),
      body: FutureBuilder<List<DonationModel>>(
        future: donationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("خطأ: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("لا يوجد تبرعات حالياً"));
          }

          final donations = snapshot.data!;

          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: donations.length,
              itemBuilder: (context, index) {
                final d = donations[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Campaign Title
                      Text(
                        d.campaignTitle.isNotEmpty
                            ? d.campaignTitle
                            : "حملة تبرع",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Amount + Method
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "💰 ${d.amount} \$",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: d.paymentMethod == "click"
                                  ? Colors.blue.withAlpha(51)
                                  : Colors.orange.withAlpha(51),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              d.paymentMethod,
                              style: TextStyle(
                                color: d.paymentMethod == "click"
                                    ? Colors.blue
                                    : Colors.orange,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Donor name
                      Text(
                        "👤 ${d.donorName}",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 5),

                      // Date
                      Text(
                        "📅 ${d.createdAt.toString().split(' ')[0]}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
