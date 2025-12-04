import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:w_phonics/models/phonics_character.dart';
import 'package:w_phonics/pages/flashcard_page.dart';
import 'package:w_phonics/pages/formation_page.dart';
import 'package:w_phonics/widgets/phonics_item_card.dart';
import 'package:w_phonics/widgets/sounding_section_widget.dart';

class LessonItemPage extends StatefulWidget {
  const LessonItemPage({
    super.key,
    required this.phonicsCharacter,
    required this.color,
  });
  final PhonicsCharacter phonicsCharacter;
  final Color color;

  @override
  State<LessonItemPage> createState() => _LessonItemPageState();
}

class _LessonItemPageState extends State<LessonItemPage> {
  @override
  Widget build(BuildContext context) {
    var phonicsCharacter = widget.phonicsCharacter;
    var phonicChar = phonicsCharacter.character;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        title: Text("Lesson /$phonicChar/"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          //
          // Story section
          PhonicsItemPageCard(
            title: "Story",
            child: Text(phonicsCharacter.story),
          ),
          //
          // Action Section
          PhonicsItemPageCard(
            title: "Action",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(phonicsCharacter.actionImage),
                Text(phonicsCharacter.actionText),
              ],
            ),
          ),
          //
          // Flash Card
          PhonicsItemPageCard(
            title: "Flash Card",
            actions: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlashcardPage(phonicChar: phonicChar),
                  ),
                );
              },
              icon: Icon(Icons.expand, color: Colors.grey.shade400),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(24),
                  ),

                  width: 150,
                  height: 150,
                  child: Center(
                    child: Text(
                      phonicChar,
                      style: TextStyle(
                        fontSize: 105,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //
          // Finger tracing
          PhonicsItemPageCard(
            title: "Formation",
            bottomItem: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormationPage(color: widget.color),
                  ),
                );
              },
              child: Text("Finger tracing"),
            ),

            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(24),
                ),
                width: 150,
                height: 150,
                child: Center(
                  child: Text(
                    phonicChar,
                    style: TextStyle(
                      fontSize: 105,
                      fontWeight: FontWeight.w900,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          //
          // Sounding
          SoundingSectionWidget(
            phonicChar: phonicChar,
            phonicsCharacter: phonicsCharacter,
          ),
          //
          // Writing
          PhonicsItemPageCard(
            title: "Writing",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Call out the sounds below, and ask the children to write them down",
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: List.generate(
                    phonicsCharacter.listOfWriting.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          child: Text(
                            phonicsCharacter.listOfWriting[index].character,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          //
          // Song
          PhonicsItemPageCard(
            title: "Song",
            child: Column(
              children: [
                Text(phonicsCharacter.songText),
                SongPlayerWidget(songAsset: widget.phonicsCharacter.songAudio),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A widget that plays audio from an asset file with play/pause controls and a seek slider.
/// 
/// This widget uses the `just_audio` package to handle audio playback.
/// It displays a slider to show/control playback progress and a play/pause button.
class SongPlayerWidget extends StatefulWidget {
  const SongPlayerWidget({super.key, required this.songAsset});
  
  /// The path to the audio asset file (e.g., "assets/audio/song.mp3")
  final String songAsset;

  @override
  State<SongPlayerWidget> createState() => _SongPlayerWidgetState();
}

class _SongPlayerWidgetState extends State<SongPlayerWidget> {
  /// The AudioPlayer instance from just_audio package that handles all audio operations
  var justAudio = AudioPlayer();
  
  /// Tracks whether audio is currently playing - used to toggle play/pause icon
  bool playing = false;
  
  /// Current playback position in seconds - updates as audio plays
  double currentSeconds = 0;
  
  /// Total duration of the audio file in seconds - used as max value for slider
  double maxSeconds = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the audio player when widget is first created
    initializeAudio();
  }

  /// Loads the audio asset and sets up a listener for playback position changes.
  /// 
  /// This method:
  /// 1. Loads the audio file from assets using setAsset()
  /// 2. Gets the total duration of the audio for the slider's max value
  /// 3. Sets up a stream listener that fires whenever playback position changes
  /// 4. Auto-stops playback when audio reaches the end
  Future<void> initializeAudio() async {
    // Load the audio file from assets - this prepares it for playback
    await justAudio.setAsset(widget.songAsset);
    
    // Get total duration in seconds for the slider's maximum value
    maxSeconds = (justAudio.duration?.inSeconds ?? 0).toDouble();

    // Listen to position changes - this stream emits the current playback position
    justAudio.positionStream.listen((duration) {
      // Update current position for the slider
      currentSeconds = duration.inSeconds.toDouble();

      // Check if audio has reached the end
      if(currentSeconds >= maxSeconds){
        print("came in to the end");
        playing = false;  // Update playing state
        justAudio.stop(); // Stop the audio player
      }

      // Rebuild widget to reflect new position on slider
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Clean up: release audio resources when widget is removed from tree
    // This prevents memory leaks and stops any ongoing playback
    justAudio.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Slider section - shows playback progress and allows seeking
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Slider to show current position and allow user to seek to different positions
              Slider(
                value: currentSeconds,  // Current playback position
                max: maxSeconds,        // Total duration of audio
                onChanged: (position) {
                  // When user drags slider, seek to that position in the audio
                  justAudio.seek(Duration(seconds: position.toInt()));
                },
              ),
              // Display current playback time in seconds
              Text(currentSeconds.toString())
            ],
          ),
          // Play/Pause button - toggles audio playback
          IconButton(
            onPressed: () {
              if (playing) {
                // If currently playing, stop the audio
                playing = false;
                justAudio.stop();
              } else {
                // If not playing, start playback
                playing = true;
                justAudio.play();
              }
              // Rebuild to update the icon (play vs pause)
              setState(() {});
            },
            // Show pause icon when playing, play icon when stopped
            icon: Icon(playing ? Icons.pause_circle : Icons.play_circle, size: 60,),
          ),
        ],
      ),
    );
  }
}
