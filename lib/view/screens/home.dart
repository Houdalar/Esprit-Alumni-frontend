import 'package:flutter/material.dart';

import '../../model/postmodel.dart';
import '../components/constum_componenets/postitem.dart';

/*lass HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(
          minHeight: 50, // set minimum height
          maxHeight: double.infinity, // set maximum height to infinity
        ),
        width: double.infinity,
        child: ListView(children: [
          const PostItem(
            postImage:
                "media/Complete technical service for your corporate event.jpeg",
            description:
                '🍀first day of esprit alumni lanching event 🔥🔥🔥🔥🔥🔥thank you so much for being here ❤️❤️❤️❤️',
            likesCount: 100,
            commentsCount: 50,
            ownerName: 'John Doe',
            ownerProfileImage:
                "media/WhatsApp Image 2023-02-15 at 7.11.38 PM.jpeg",
          ),
          const PostItem(
            postImage:
                "media/Complete technical service for your corporate event.jpeg",
            description:
                '🍀first day of esprit alumni lanching event 🔥🔥🔥🔥🔥🔥thank you so much for being here ❤️❤️❤️❤️',
            likesCount: 100,
            commentsCount: 50,
            ownerName: 'John Doe',
            ownerProfileImage:
                "media/WhatsApp Image 2023-02-15 at 7.11.38 PM.jpeg",
          ),
        ]),
      ),
    );
  }
}*/

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<PostModel>> _postsFuture;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _postsFuture = _fetchPosts();
  }

  Future<List<PostModel>> _fetchPosts() async {
    // Replace this with your own API call to fetch posts
    final response = await http.get(Uri.parse('https://your-api.com/posts'));
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List;
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search posts',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Handle search button press here
              },
            ),
          ),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints(
          minHeight: 50, // set minimum height
          maxHeight: double.infinity, // set maximum height to infinity
        ),
        width: double.infinity,
        child: FutureBuilder<List<Post>>(
          future: _postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load posts'));
            } else {
              final posts = snapshot.data;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostItem(
                    postImage: post.image,
                    description: post.description,
                    likesCount: post.likes,
                    commentsCount: post.comments,
                    ownerName: post.ownerName,
                    ownerProfileImage: post.ownerProfileImage,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
