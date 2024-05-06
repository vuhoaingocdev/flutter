import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_linhvq/video_model.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget{

  final VideoModel videoModel;
  final PageController pageController;
  final int pageIndex;
  const VideoScreen({Key? key, required this.videoModel, required this.pageController, required this.pageIndex}) : super(key: key);

  @override
  _VideoScreen createState() => _VideoScreen();
}

class _VideoScreen extends State<VideoScreen>{

  late VideoPlayerController _controller;

  late YoutubePlayerController  _youtubePlayerController;

  @override
  void initState(){

    if(widget.videoModel.linkVideo.contains("youtube")){
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoModel.linkVideo)!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
      // _initializeVideoPlayerFuture = null;
    }else {
      _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      );
      _controller.setLooping(false);
    }
    super.initState();
  }
  
  @override
  void dispose(){
    _controller.dispose();
    _youtubePlayerController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot){
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              widget.videoModel.linkVideo.contains("youtube") ? Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.3),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.7,
                      child: Stack(
                        children: [
                          YoutubePlayer(controller: _youtubePlayerController,
                          showVideoProgressIndicator: true,
                          onReady: (){
                            setState(() {
                                        Future.delayed( _youtubePlayerController.value.metaData.duration, (){
                                          setState(() {
                                            widget.pageController.jumpToPage(3);
                                          });
                                        });
                            });
                          })
                        ],
                      )
                  )) :  Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.3),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.7,
                      child: Stack(
                        children: [
                          VideoPlayer(_controller),
                          Center(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(_controller.value.isPlaying){
                                    _controller.pause();
                                  }else{
                                    _controller.play();
                                    Future.delayed( _controller.value.duration, (){
                                      setState(() {
                                        widget.pageController.jumpToPage(2);
                                      });
                                    });
                                  }
                                });
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.25), // border color
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2), // border width
                                  child: Container( // or ClipRRect if you need to clip the content
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey, // inner circle color
                                    ),
                                    child:  Icon( _controller.value.isPlaying ? Icons.pause :  Icons.play_circle_filled, size: 28,), // inner content
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  )),
                 Positioned(
                  bottom: 200,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.videoModel.publicTime),
                      Text(widget.videoModel.titleVideo, overflow: TextOverflow.ellipsis, maxLines: 3,),
                      Text(widget.videoModel.description, overflow: TextOverflow.ellipsis, maxLines: 3,),
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }

}