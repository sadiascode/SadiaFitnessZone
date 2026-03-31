import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../common/app_shell.dart';

class ChatsScreenContent extends StatefulWidget {
  final bool isActive;
  const ChatsScreenContent({super.key, this.isActive = false});

  @override
  State<ChatsScreenContent> createState() => _ChatsScreenContentState();
}

class _ChatsScreenContentState extends State<ChatsScreenContent> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF7),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Chat",
          style: TextStyle(
            color: Color(0xffE0712D),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xffE0712D)),
            onSelected: () {
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'details',
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 20),
                    SizedBox(width: 8),
                    Text('Details'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text('Clear History', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isLoadingHistory)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchChatHistory,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: _messages.length + ((_showPlaceholderImage && !_isLoadingHistory) ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_showPlaceholderImage && !_isLoadingHistory && index == 0) {
                    return Center(
                      child: Image.asset(
                        'assets/text.png',
                        height: 300,
                        width: 300,
                      ),
                    );
                  }

                  final msgIndex = (_showPlaceholderImage && !_isLoadingHistory) ? index - 1 : index;
                  final msg = _messages[msgIndex];
                  final isUser = msg['sender'] == 'user';
                  final messageType = msg['type'] ?? 'text';
                  final isTyping = msg['isTyping'] == true;


                  if (isTyping) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          "Typing...",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    );
                  }

                  final isPlaying = _currentlyPlayingPath == (msg['voiceUrl'] ?? msg['audioPath']) && _playerState == PlayerState.playing;

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: messageType == 'voice'
                          ? () => _playVoiceMessage(msg['audioPath'], voiceUrl: msg['voiceUrl'])
                          : null,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: isUser ? const Color(0xFFE0712D) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: isUser ? null : Border.all(color: Colors.grey.shade300),
                          boxShadow: isPlaying
                              ? [BoxShadow(color: const Color(0xFFE0712D).withOpacity(0.3), blurRadius: 8, spreadRadius: 2)]
                              : null,
                        ),
                        child: messageType == 'voice'
                            ? Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.white.withOpacity(0.2) : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isPlaying ? Icons.stop : Icons.play_arrow,
                                color: isUser ? Colors.white : const Color(0xFFE0712D),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                msg['duration'] != null && msg['duration'] != '?'
                                    ? "Voice (${msg['duration']}s)"
                                    : "Voice Message",
                                style: TextStyle(
                                  color: isUser ? Colors.white : Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                            : messageType == 'image'
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: msg['imagePath'] != null && msg['imagePath'].toString().startsWith('http')
                                  ? Image.network(
                                msg['imagePath'],
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  width: 200,
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.error),
                                ),
                              )
                                  : Image.file(
                                File(msg['imagePath'] ?? ''),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (msg['isLoading'] == true) ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Analyzing...",
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        )
                            : Text(
                          msg['text'] ?? '',
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomText(
                messageController: _messageController,
                onSend: (text) {
                  _sendMessage(text);
                  _scrollToBottom();
                },
                onVoiceRecorded: (voiceData) {
                  _sendVoiceMessage(voiceData);
                },
                onImageCaptured: (imageFile) {
                  _sendImageMessage(imageFile);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
