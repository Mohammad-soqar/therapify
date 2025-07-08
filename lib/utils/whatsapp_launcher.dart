import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsAppChat(String phoneNumber, {String message = ''}) async {
  // Remove the '+' if it exists and encode the message
  final formattedPhone = phoneNumber.replaceAll('+', '').replaceAll(' ', '');
  final encodedMessage = Uri.encodeComponent(message);

  final Uri url = Uri.parse('https://wa.me/$formattedPhone?text=$encodedMessage');

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    // Show a dialog or snackbar for user feedback
    throw Exception('Could not launch WhatsApp. Make sure it\'s installed.');
  }
}
