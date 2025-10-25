import 'package:flutter/material.dart';

class DashboardTabunganSkeleton extends StatelessWidget {
  const DashboardTabunganSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final Color skeletonColor = Colors.grey[300]!;
    final Color highlightColor = Colors.grey[100]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Balance Card Skeleton
        Card(
          color: skeletonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      color: highlightColor,
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 120,
                      height: 16,
                      color: highlightColor,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: 180,
                  height: 28,
                  color: highlightColor,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // IncomeExpenseCards Skeleton
        Column(
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
      ],
    );
  }
}
