import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final audio = AudioPlayer();
  // final url =
  //     'https://barrabrava.net/audios/la-12-boca-juniors/la-12-boca-juniors-a-todas-partes-voy-con-vos-12041954-barrabrava-net.mp3';
  // // final url = // 'https://www.videvo.net/es/efecto-de-sonido/soccer-18/441430/';
  final url =
      'https://radioteca.net/media/uploads/audios/2013_07/aud_e2y4bf4kw2onv2hr.mp3';
  final golUrl = 'http://www.sonidosmp3gratis.com/sounds/gol-gol-gol.mp3';

  bool isPlay = true;
  bool isStop = false;
  iniciarAudio() async {
    await audio.setSourceUrl(url);
    await audio.setVolume(1);
    await audio.resume();
    isPlay = true;
    isStop = false;
    await audio.setReleaseMode(ReleaseMode.loop);
    notifyListeners();
  }

  playPause() async {
    if (isPlay) {
      await audio.pause();
    } else {
      if (!isStop) {
        await audio.resume();
      }

      iniciarAudio();
    }
    isPlay = !isPlay;
    notifyListeners();
  }

  audioGol() async {
    await audio.stop();
    await audio.setSourceUrl(golUrl);
    await audio.setVolume(1);

    await audio.resume();
  }

  stop() async {
    if (isStop) {
      iniciarAudio();
      return;
    }
    await audio.stop();
    isPlay = false;
    isStop = true;
    notifyListeners();
  }
}
