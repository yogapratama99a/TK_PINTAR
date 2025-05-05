import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/chat-parent_controller.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/widgets/message_bubble.dart';
import 'package:tk_pertiwi/views/widgets/message_input.dart';

class SendMessageScreen extends StatefulWidget {
  final int receiverId;
  final String receiverName;
  final String receiverImage;
  final String? subject;

  const SendMessageScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage,
    this.subject,
  });

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  late final ChatController controller;

@override
void initState() {
  super.initState();
  controller = Get.put(ChatController());
  WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.prepareChat(widget.receiverId.toString());
  });
}


  @override
  void dispose() {
    Get.delete<ChatController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(child: _buildMessagesList()),
          MessageInput(
            receiverId: widget.receiverId,
            controller: controller,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(widget.receiverImage),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.receiverName,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              if (widget.subject != null)
                Text(
                  widget.subject!,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
            ],
          ),
        ],
      ),
      flexibleSpace: Container(
        color: AppColors.blue,
      ),
    );
  }

  Widget _buildMessagesList() {
    return Obx(() {
      if (controller.messages.isEmpty) {
        return const Center(child: Text('Belum ada pesan'));
      }

      return ListView.builder(  // <-- tambahkan return disini
        controller: controller.scrollController,
        itemCount: controller.messages.length,
        itemBuilder: (context, index) {
          final message = controller.messages[index];
          return MessageBubble(
            isMe: message['isMe'] as bool,
            message: message['message'] as String,
            time: message['time'] as DateTime,
          );
        },
      );
    });
  }
}
