import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:amiriy/screens/global_widgets/tab_item.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class AudioItem extends StatelessWidget {
  const AudioItem({
    super.key,
    required this.audioBooksModel,
    required this.saveOnTap,
    required this.listOnTap,
    required this.playOnTap,
    required this.isLiked,
  });

  final AudioBooksModel audioBooksModel;
  final VoidCallback saveOnTap;
  final VoidCallback listOnTap;
  final VoidCallback playOnTap;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: listOnTap,
      leading: TabItem(
        onTap: playOnTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            10,
          ),
          child: Image.asset(
            AppImages.music,
            height: 50.h,
            width: 50.w,
            fit: BoxFit.cover,
            color: Colors.red,
            colorBlendMode: BlendMode.colorBurn,
          ),
        ),
      ),
      title: Text(
        audioBooksModel.bookName,
      ),
      trailing: TabItem(
          onTap: saveOnTap,
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: Theme.of(context).iconTheme.color,
            size: 30.w,
          )),
    );
  }
}
