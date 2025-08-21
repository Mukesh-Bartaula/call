import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:video_call/constant.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({super.key});

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  final channelName = 'test';
  final uId = 0;
  bool _isEngineReady = false;
  RtcEngine? _engine;
  int? _remoteUid;

  // states for call icon UI
  bool micMuted = true;
  bool speakerOn = true;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // Request permissions
    await [Permission.microphone, Permission.camera].request();

    // Create Engine

    _engine = createAgoraRtcEngine();
    await _engine!.initialize(RtcEngineContext(appId: AgoroInfo.appId));
    await _engine!.enableAudio();

    // Listen for events
    if (_engine != null) {
      _engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (connection, elapsed) {
            log("local user ${connection.localUid} joined");
          },
          onUserJoined: (connection, remoteUid, elapsed) {
            log("Remote user joined: $remoteUid");
            setState(() {
              _remoteUid = remoteUid;
            });
          },
          onUserOffline: (connection, remoteUid, reason) {
            log("Remote user left: $remoteUid");
            setState(() {
              _remoteUid = null;
            });
          },
        ),
      );
    }

    // Join channel (here appSign is actually a TEMP TOKEN)
    await _engine!.joinChannel(
      token: AgoroInfo.tempToken,
      channelId: channelName,
      uid: uId,
      options: ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileCommunication,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        enableAudioRecordingOrPlayout: micMuted,

        // explicitly disable video

        // explicitly enable audio
        publishMicrophoneTrack: micMuted,
      ),
    );
    // engine is ready, update UI
    setState(() {
      _isEngineReady = true;
    });
  }

  @override
  void dispose() {
    _engine?.leaveChannel();
    _engine?.release();
    super.dispose(); // call this at the end
  }

  Widget _renderRemoteAudio() {
    if (_remoteUid != null && _engine != null) {
      return Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$_remoteUid[0]',
                style: const TextStyle(
                  fontSize: 44,
                  color: Colors.blueAccent,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 137, 188, 230),
        ),
        child: const Center(
          child: Text(
            'Waiting for user to join...',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blueAccent,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: _renderRemoteAudio()),
        Align(
          alignment: Alignment.bottomCenter,

          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      micMuted = !micMuted;
                    });
                    if (micMuted == false) {
                      _engine?.disableAudio();
                    } else {
                      _engine?.enableAudio();
                    }
                  },
                  shape: const CircleBorder(),
                  fillColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      micMuted ? Icons.mic : Icons.mic_off,
                      color: Colors.blue,
                      size: 25,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: const CircleBorder(),
                  fillColor: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.call_end, color: Colors.white, size: 35),
                  ),
                ),

                RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      speakerOn = !speakerOn;
                    });
                    _engine?.setEnableSpeakerphone(speakerOn);
                  },
                  shape: const CircleBorder(),
                  fillColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      speakerOn
                          ? Icons.volume_up_outlined
                          : Icons.volume_down_rounded,
                      color: Colors.blue,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
