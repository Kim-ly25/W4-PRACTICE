import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  String statusText(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.notDownloaded:
        return '';
      case DownloadStatus.downloading:
        return 'completed';
      case DownloadStatus.downloaded:
        return 'completed';
    }
  }

  Widget buildIcon() {
    switch (controller.status) {
      case DownloadStatus.notDownloaded:
        return IconButton(
          icon: const Icon(Icons.download),
          onPressed: controller.startDownload,
        );
      case DownloadStatus.downloading:
        return const SizedBox();
      case DownloadStatus.downloaded:
        return const Icon(Icons.folder);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final resource = controller.ressource;
        final progress = controller.progress;
        final totalSize = resource.size;
        final downloaded = (totalSize * progress).toStringAsFixed(1);
        final percent = (progress * 100).toStringAsFixed(1);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(         
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          
          child: ListTile(
            title: Text(resource.name),
            subtitle: Text(
              "$percent% ${statusText(controller.status)} - $downloaded of $totalSize MB",
            ),
            trailing: buildIcon(),
          ),
        );
      },
    );
  }
}
