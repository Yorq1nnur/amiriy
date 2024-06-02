import 'package:amiriy/bloc/image/image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';

void takeAnImage(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            ListTile(
              onTap: () async {
                context.read<ImageBloc>().add(GetFromGalleryEvent());
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              leading: const Icon(Icons.photo_album_outlined),
              title: const Text("Gallereyadan olish"),
            ),
            ListTile(
              onTap: () async {
                context.read<ImageBloc>().add(
                      GetFromCameraEvent(),
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              leading: const Icon(Icons.camera_alt),
              title: const Text(
                "Kameradan olish",
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      );
    },
  );
}
