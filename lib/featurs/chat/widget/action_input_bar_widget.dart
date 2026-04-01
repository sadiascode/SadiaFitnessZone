import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ActionInputBarWidget extends StatefulWidget {
  const ActionInputBarWidget({super.key});

  @override
  State<ActionInputBarWidget> createState() => _ActionInputBarWidgetState();
}

class _ActionInputBarWidgetState extends State<ActionInputBarWidget>
    with SingleTickerProviderStateMixin {
  bool _isRecording = false;
  int _seconds = 0;

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
      _seconds = 0;
    });
  }

  String _formatTime(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return "$m:$sec";
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        border: Border.all(
          color: _isRecording
              ? Colors.red
              : const Color(0xff86CC55).withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          if (_isRecording)
            const Icon(Icons.close, color: Colors.red)
          else
            GestureDetector(
              onTap: () async {
                final XFile? image =
                await _picker.pickImage(source: ImageSource.camera);

                if (image != null) {
                  // image use here
                  print(image.path);
                }
              },
              child: const Icon(
                Icons.camera_alt,
                size: 32,
                color: Color(0xff86CC55),
              ),
            ),

          const SizedBox(width: 12),

          Expanded(
            child: _isRecording
                ? Row(
              children: [
                FadeTransition(
                  opacity: _pulseController,
                  child: const Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 12,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "RECORDING... ${_formatTime(_seconds)}",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            )
                : const SizedBox.shrink(),
          ),

          const SizedBox(width: 12),

          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: _toggleRecording,
            child: AnimatedScale(
              scale: _isRecording ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                  _isRecording ? Colors.red : const Color(0xff86CC55),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isRecording ? Icons.stop : Icons.mic,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),

          if (!_isRecording) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () async {
                final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  print(image.path); // use image
                }
              },
              child: const Icon(
                Icons.photo_library,
                size: 32,
                color: Color(0xff86CC55),
              ),
            ),
          ],
        ],
      ),
    );
  }
}