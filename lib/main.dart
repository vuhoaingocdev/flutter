import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:test_linhvq/video_model.dart';
import 'package:test_linhvq/video_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;

  late Future<void> _initializeVideoPlayerFuture;

  late YoutubePlayerController _youtubePlayerController;

  late int pageIndexNext;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=egMWlD3fLJ8") ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  List<VideoModel> list = <VideoModel>[];

  @override
  Widget build(BuildContext context) {

    list.add(new VideoModel(
      videoId: 1,
      titleVideo: "Video 1",
      linkVideo: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
      typeVideo: 3,
      videoViews: 3,
      category: 11,
      description: "Description Video `",
      image: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
      isFeature: 1,
      publicTime: "2024-04-17 15:00:39",
    ));



    list.add(new VideoModel(
      videoId: 1,
      titleVideo: "Video 2",
      linkVideo: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
      typeVideo: 3,
      videoViews: 3,
      category: 11,
      description: "Description Video `",
      image: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
      isFeature: 1,
      publicTime: "2024-04-17 15:00:39",
    ));

    list.add(new VideoModel(
      videoId: 1,
      titleVideo: "Video 3",
      linkVideo: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
      typeVideo: 3,
      videoViews: 3,
      category: 11,
      description: "Description Video `",
      image: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
      isFeature: 1,
      publicTime: "2024-04-17 15:00:39",
    ));

    list.add(new VideoModel(
      videoId: 1,
      titleVideo: "Youtube 1",
      linkVideo: "https://www.youtube.com/watch?v=egMWlD3fLJ8",
      typeVideo: 3,
      videoViews: 3,
      category: 11,
      description: "Description Youtube 2",
      image: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
      isFeature: 1,
      publicTime: "2024-04-17 15:00:39",
    ));


    List<Widget> pages = <Widget>[];

    list.forEach((item) {
      pages.add(VideoScreen(pageController: pageController, videoModel: item, pageIndex: list.indexOf(item) < list.length ?  list.indexOf(item) + 1 : 0));
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return ExpandablePageView(
              controller: pageController,
              onPageChanged: (index) {
                // Handle page change events here
              },
              children: pages,
            );
          },
        )
    );
  }
}