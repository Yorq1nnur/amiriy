import 'dart:async';

import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:my_utils/my_utils.dart';

class PdfViewScreen extends StatelessWidget {
  PdfViewScreen({super.key, required this.bookModel});

  final BookModel bookModel;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24.w,
              color: Theme.of(context).iconTheme.color,
            )),
        title: Text(
          bookModel.bookName,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 20.w,
              ),
        ),
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromUrl(
        bookModel.pdfBookUrl.isNotEmpty
            ? bookModel.pdfBookUrl
            : "https://firebasestorage.googleapis.com/v0/b/e-commerce-app-863de.appspot.com/o/files%2Fpdf%2FLug%20'at.%20%20O%20'zbek-Turkca-ruscha.pdf?alt=media&token=3c58f9b7-3e61-4516-98ee-c89217facdc3",
        errorWidget: (
          dynamic error,
        ) =>
            Center(
          child: Text(
            error.toString(),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (
          _,
          AsyncSnapshot<PDFViewController> snapshot,
        ) {
          if (snapshot.hasData && snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<String>(
                      stream: _pageCountController.stream,
                      builder: (_, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 50.w),
                            padding: EdgeInsets.all(25.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(snapshot.data!),
                          );
                        }
                        return const CircularProgressIndicator();
                      }),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 24.w,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: () async {
                          final PDFViewController pdfController =
                              snapshot.data!;
                          final int currentPage =
                              (await pdfController.getCurrentPage())! - 1;
                          if (currentPage >= 0) {
                            await pdfController.setPage(
                              currentPage,
                            );
                          }
                        },
                      ),
                      50.getW(),
                      FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(Icons.arrow_forward_ios,
                            size: 24.w,
                            color: Theme.of(context).iconTheme.color),
                        onPressed: () async {
                          final PDFViewController pdfController =
                              snapshot.data!;
                          final int currentPage =
                              (await pdfController.getCurrentPage())! + 1;
                          final int numberOfPages =
                              await pdfController.getPageCount() ?? 0;
                          if (numberOfPages > currentPage) {
                            await pdfController.setPage(currentPage);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
