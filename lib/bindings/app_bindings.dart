import 'package:esprit_alumni_frontend/viewmodel/chat/controllers/conversation_controller.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/controllers/messages_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConversationController>(() => ConversationController());
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
