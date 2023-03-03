import 'package:flutter/material.dart';

class PostsFragment extends StatefulWidget {
  const PostsFragment({Key? key}) : super(key: key);

  @override
  State<PostsFragment> createState() => _PostsFragmentState();
}

class _PostsFragmentState extends State<PostsFragment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('Assets/images/profile_image.png')
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Houssem',
                        style: TextStyle(
                          fontFamily: 'Mukta Malar',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Icon(
                        Icons.more_vert,
                        color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  'Don\'t miss this opportunity',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Image(
                  image: const AssetImage('Assets/images/post.png'),
                  height: 150,
                  width: double.infinity,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(width: 120),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.heart_broken, color: Color.fromRGBO(182, 39, 8, 1.0), size: 20),
                          const SizedBox(width: 6),
                          Text(
                            '12k',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.comment_outlined, color: Color.fromRGBO(182, 39, 8, 1.0), size: 20),
                          const SizedBox(width: 6),
                          Text(
                            '100',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Mukta Malar',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.share_outlined, color: Color.fromRGBO(182, 39, 8, 1.0), size: 20),
                          const SizedBox(width: 6),
                          Text(
                            'Share',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('Assets/images/profile_image.png')
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Houssem',
                        style: TextStyle(
                          fontFamily: 'Mukta Malar',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  'Don\'t miss this opportunity',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Image(
                  image: const AssetImage('Assets/images/post.png'),
                  height: 150,
                  width: double.infinity,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(width: 120),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.heart_broken, color: Color.fromRGBO(182, 39, 8, 1.0), size: 20),
                          const SizedBox(width: 6),
                          Text(
                            '12k',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.comment_outlined, color: Color.fromRGBO(182, 39, 8, 1.0), size: 20),
                          const SizedBox(width: 6),
                          Text(
                            '100',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Mukta Malar',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.share_outlined, color: Color.fromRGBO(182, 39, 8, 1.0), size: 20),
                          const SizedBox(width: 6),
                          Text(
                            'Share',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('Assets/images/profile_image.png')
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Houssem',
                        style: TextStyle(
                          fontFamily: 'Mukta Malar',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  'Don\'t miss this opportunity',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Image(
                  image: const AssetImage('Assets/images/post.png'),
                  height: 150,
                  width: double.infinity,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(width: 120),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.heart_broken, color: Color.fromRGBO(182, 39, 8, 1.0), size: 20),
                          const SizedBox(width: 6),
                          Text(
                            '12k',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.comment_outlined, color: Color.fromRGBO(182, 39, 8, 1.0), size: 20),
                          const SizedBox(width: 6),
                          Text(
                            '100',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Mukta Malar',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.share_outlined, color: Color.fromRGBO(182, 39, 8, 1.0), size: 20),
                          const SizedBox(width: 6),
                          Text(
                            'Share',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}