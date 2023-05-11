import 'dart:developer';
import 'package:esprit_alumni_frontend/model/chat_model.dart';
import 'package:esprit_alumni_frontend/model/conversation.dart';
import 'package:esprit_alumni_frontend/model/user_info_model.dart';
import 'package:esprit_alumni_frontend/model/usermodel.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/services/messages_service.dart';
import 'package:esprit_alumni_frontend/viewmodel/userViewModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageController extends GetxController {
  late var conversationsList;
  late String userId;
  late var chatModels;
  late var users;
  //RxString? lastMessage;

  @override
  void onInit() async {
    super.onInit();
    conversationsList = <ConversationModel>[].obs;
    chatModels = <ChatModel?>[].obs;
    users = <User>[].obs;
    getUserId().then((value) async {
      userId = value ?? "";
      await getUserConversations();
    });
    await getUsers();

    //.then((allUsers) {
    //   for (var element in allUsers) {
    //     users.add(element);
    //   }
    //   update();
    // });
  }

  @override
  void onClose() {
    super.onClose();
    conversationsList = <ConversationModel>[].obs;
    chatModels = <ChatModel?>[].obs;
    users = <User>[].obs;
    log("dispoooooooooooooose");
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log(prefs.getString('id') ?? 'id not displayed');
    return prefs.getString('id');
  }

  getUserConversations() async {
    MessagesService.getUserConversations(userId).then((value) {
      conversationsList = <ConversationModel>[].obs;
      conversationsList.addAll(value);
      log(conversationsList.toString());
      //  conversationsList.refresh();
      // update();
    }).then((value) async {
      if (conversationsList.isEmpty) {
        // Initialize chatModels with all users if there are no conversations
        for (var user in users) {
          ChatModel chatModel = userToChatModel(user);
          chatModels.add(chatModel);
        }
      } else {
        for (var conversation in conversationsList) {
          final otherUserId = userId == conversation.targetId
              ? conversation.sourceId
              : conversation.targetId;
          final lastMessageId = conversation.messagesList?.last;
          String? lastMessage;
          await getMessage(lastMessageId ?? "").then((value) {
            lastMessage = value;
            update();
          });
          await getUserInfo(otherUserId ?? "").then((userInfo) {
            log(userInfo.toString());
            ChatModel chatModel = ChatModel(
              name: userInfo?.username,
              image: userInfo?.profileImage,
              currentMessage: lastMessage,
              targetId: otherUserId,
              //time: createdAt
            );
            chatModels.add(chatModel);
            update();
          });
        }
      }
    });
    conversationsList.refresh();
    log("chatlistModel ${chatModels.length.toString()}");
    log("conversationsList ${conversationsList.length.toString()}");
  }

  Future<UserInfoModel?> getUserInfo(String targetId) async {
    final userInfo = await MessagesService.getUserInfo(targetId);
    return UserInfoModel.fromJson(userInfo ?? {});
  }

  Future<String> getMessage(String messageId) async {
    final message = await MessagesService.getMessage(messageId);
    return message;
  }

//  Future<RxList<User>>
  getUsers() async {
    final usersList = await UserViewModel.getUsers();
    users.addAll(usersList);
    log("users list: $usersList");
    update();
    // return users;
  }

  ChatModel userToChatModel(User user) {
    return ChatModel(
      name: user.username,
      image: "",
      currentMessage: "",
      time: "",
      targetId: user.id,
    );
  }

  Future<ConversationModel> getConversation(
      String targetId, String sourceId) async {
    return await MessagesService.getConversation(targetId, sourceId);
  }

  Future<UserInfoModel> getOtherUser(
      String currentUserId, String sourceId, String targetId) async {
    return await MessagesService.getOtherUser(
        currentUserId, sourceId, targetId);
  }
}
