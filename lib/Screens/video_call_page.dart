import 'package:flutter/material.dart';
import 'dart:math';
import 'package:video_call/constant.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallPage extends StatefulWidget {
  final String callID;
  const VideoCallPage({super.key, required this.callID});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late final String userId;

  @override
  void initState() {
    super.initState();
    // For a real app, this should be a stable, unique identifier for the logged-in user.
    userId = Random().nextInt(10000).toString();
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: AppInfo
          .appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: AppInfo
          .appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userId,
      userName: 'user_name$userId',
      callID: widget.callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
