import 'package:flutter/material.dart';

class RiwayatSingkatSkeleton extends StatelessWidget {
  const RiwayatSingkatSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final Color skeletonColor = Colors.grey[300]!;
    final Color highlightColor = Colors.grey[100]!;

    return Card(
      color: skeletonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        color: highlightColor,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Container(
                          width: 100,
                          height: 16,
                          color: highlightColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  height: 16,
                  color: highlightColor,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Transaction List Skeleton
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    dense: true,
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: skeletonColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    title: Container(
                      width: 120,
                      height: 13,
                      color: skeletonColor,
                    ),
                    subtitle: Container(
                      width: 80,
                      height: 11,
                      color: skeletonColor,
                    ),
                    trailing: Container(
                      width: 60,
                      height: 14,
                      color: skeletonColor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
