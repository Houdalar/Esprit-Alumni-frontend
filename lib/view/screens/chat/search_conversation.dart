import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/widgets/conversation_search_item.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/widgets/search_bar.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/controllers/conversation_controller.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/controllers/messages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchConversation extends StatefulWidget {
  const SearchConversation({super.key});

  @override
  State<SearchConversation> createState() => _SearchConversationState();
}

class _SearchConversationState extends State<SearchConversation> {
  final conversationController = Get.put(ConversationController());
  final messsageController = Get.put(MessageController());

  @override
  void initState() {
    messsageController.getUserConversations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration:
                const BoxDecoration(gradient: AppColors.gradientBackground),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Start Conversation",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    const Icon(
                      Icons.edit,
                      color: AppColors.white,
                    ),
                  ],
                ),
                SearchBar(
                  searchText: '',
                  onSearch: conversationController.onSearchTextChanged,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                    ),
                    Obx(() {
                      if (conversationController.isSearchActive.value) {
                        return ListView.builder(
                            itemCount:
                                conversationController.searchResults.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ConversationSearchItem(
                                username: conversationController
                                    .searchResults[index].username,
                                profileImage: conversationController
                                    .searchResults[index].profileImage,
                                targetUserId: conversationController
                                    .searchResults[index].userId,
                                sourchat: messsageController.userId,
                              );
                            });
                      } else {
                        return Center(
                          child: Text(
                            "No search performed yet !",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            )),
                          ),
                        );
                      }
                    }),
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
