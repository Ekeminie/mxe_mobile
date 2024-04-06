import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

bool? isImage(String path) {
  final mimeType = lookupMimeType(path);

  return mimeType?.startsWith('image/');
}

bool isDocument(String path) {
  final mimeType = lookupMimeType(path);

  return mimeType == ('application/msword') || mimeType == ('application/pdf');
}

MediaType getMimeType(String s) {
  MediaType mediaType;
  if (isImage(s) ?? false) {
    mediaType = MediaType("image", "png");
  } else {
    mediaType = MediaType("application", "pdf");
  }
  return mediaType;
}
