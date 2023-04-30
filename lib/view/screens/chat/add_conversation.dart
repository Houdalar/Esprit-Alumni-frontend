import 'package:esprit_alumni_frontend/view/screens/chat/widgets/conversation_search_item.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/widgets/search_bar.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/controllers/conversation_controller.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/controllers/messages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddConversation extends StatefulWidget {
  const AddConversation({Key? key}) : super(key: key);

  @override
  State<AddConversation> createState() => _AddConversationState();
}

class _AddConversationState extends State<AddConversation> {
  final TextEditingController _searchController = TextEditingController();
  final conversationController = Get.put(ConversationController());
  final messsageController = Get.put(MessageController());

  @override
  void initState() {
    messsageController.getUserConversations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                "Select a user",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
          SearchBar(
            searchText: '',
            onSearch: conversationController.onSearchTextChanged,
          ),
          Expanded(
            child: Obx(() {
              if (conversationController.isSearchActive.value) {
                return ListView.builder(
                    itemCount: conversationController.searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ConversationSearchItem(
                        username: conversationController
                            .searchResults[index].username,
                        profileImage: conversationController
                            .searchResults[index].profileImage,
                        chatModel: messsageController.chatModels[index],
                        sourchat: messsageController.userId,
                      );
                    });
              } else {
                return const Center(
                  child: Text("No results found"),
                );
              }
            }),
          )
        ],
      )),
    );
  }
}
