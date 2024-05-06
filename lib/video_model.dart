class VideoModel{
  late int videoId;
  late String titleVideo;
  late String linkVideo;
  late int typeVideo;
  late int videoViews;
  late int category;
  late String description;
  late String image;
  late int isFeature;
  late String publicTime;

  VideoModel({
    required this.description,
    required this.publicTime,
    required this.linkVideo,
    required this.category,
    required this.image,
    required this.isFeature,
    required this.titleVideo,
    required this.typeVideo,
    required this.videoId,
    required this.videoViews
  });

}