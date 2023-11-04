import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:zoom_replica/resources/auth_methods.dart';
import 'package:zoom_replica/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods =FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String userName = '',
  }) async {
    try {
      var jitsiMeet = JitsiMeet();
      String name;
      if(userName.isEmpty){
        name=_authMethods.user.displayName!;
      }else {
        name=userName;
      }
      var options = JitsiMeetConferenceOptions(
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
        },
        userInfo: JitsiMeetUserInfo(
            displayName: name,
            email: _authMethods.user.email),
      );
      _firestoreMethods.addToMeetingHistory(roomName);
      jitsiMeet.join(options);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
