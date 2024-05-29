import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:amiriy/screens/global_widgets/image_item.dart';
import 'package:amiriy/screens/global_widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class AudioItem extends StatelessWidget {
  const AudioItem({
    super.key,
    required this.audioBooksModel,
    required this.saveOnTap,
    required this.playOnTap,
    required this.isLiked,
  });

  final AudioBooksModel audioBooksModel;
  final VoidCallback saveOnTap;
  final VoidCallback playOnTap;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: playOnTap,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(
          10,
        ),
        child: ImageItem(
          imageUrl: audioBooksModel.imageUrl,
          width: 50.w,
          height: 50.h,
        ),
      ),
      title: Text(
        audioBooksModel.bookName,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(fontWeight: FontWeight.w900, fontSize: 16.sp),
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
