class AIService {
  static String getReply(String message) {
    message = message.toLowerCase();

    if (message.contains('hi')) {
      return 'Hello! How can I help you?';
    } else if (message.contains('flutter')) {
      return "Flutter is Google's UI toolkit.";
    } else if (message.contains('who are you')) {
      return 'I am Nova AI Assistant.';
    } else if (message.contains('bye')) {
      return 'Goodbye!';
    } else {
      return 'Hi , Iam Sorry, I am still learning....';
    }
  }
}
