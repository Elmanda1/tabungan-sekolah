import 'package:flutter/material.dart';

class RiwayatListSkeleton extends StatelessWidget {
  const RiwayatListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final Color skeletonColor = Colors.grey[300]!;
    final Color highlightColor = Colors.grey[100]!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Income and Expenses Cards Skeleton
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 45.0, 16.0, 16.0),
            child: Column(
              children: [
                Card(
                  color: skeletonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: highlightColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              height: 12,
                              color: highlightColor,
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 120,
                              height: 18,
                              color: highlightColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Card(
                  color: skeletonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: highlightColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              height: 12,
                              color: highlightColor,
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 120,
                              height: 18,
                              color: highlightColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Transaction List Header Skeleton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  color: highlightColor,
                ),
                const SizedBox(width: 8),
                Container(
                  width: 100,
                  height: 22,
                  color: highlightColor,
                ),
              ],
            ),
          ),
          // Transaction List Skeleton Items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: List.generate(3, (dateIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: 150,
                        height: 14,
                        color: highlightColor,
                      ),
                    ),
                    ...List.generate(2, (transactionIndex) {
                      return Card(
                        color: skeletonColor,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          dense: true,
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: highlightColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          title: Container(
                            width: 100,
                            height: 14,
                            color: highlightColor,
                          ),
                          subtitle: Container(
                            width: 80,
                            height: 11,
                            color: highlightColor,
                          ),
                          trailing: Container(
                            width: 60,
                            height: 14,
                            color: highlightColor,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
