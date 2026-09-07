import 'package:flutter/material.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class MyPostsListWidget extends StatelessWidget {
  const MyPostsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6, // عدد المنشورات التجريبية
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: const CircleAvatar(
              radius: 24,
              backgroundColor: AppTheme.primaryDark,
              child: Text(
                'F', // حرف اسم صاحب المنشور
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            title: Text(
              'My  Post ${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Published • ${index + 1}h ago',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.favorite_border, size: 16, color: Colors.red),
                    SizedBox(width: 4),
                    Text('10', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 16),
                    Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text('3', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            // 
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
            onTap: () {
              // سيتم ربط فتح تفاصيل المنشور لاحقاً
            },
          ),
        );
      },
    );
  }
}