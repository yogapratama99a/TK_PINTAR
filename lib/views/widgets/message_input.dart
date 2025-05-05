import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/chat-parent_controller.dart';

class MessageInput extends StatelessWidget {
  final int receiverId;
  final ChatController controller;

  const MessageInput({
    super.key,
    required this.receiverId,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: Column(
        children: [
          _buildMessageTemplates(controller),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.messageController,
                  decoration: InputDecoration(
                    hintText: 'Ketik pesan...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  maxLines: 3,
                  minLines: 1,
                  onChanged: (value) =>
                      controller.hasMessage.value = value.isNotEmpty),
              ),
              Obx(() {
                final hasMessage = controller.hasMessage.value;
                return IconButton(
                  icon: Icon(Icons.send,
                      color: hasMessage ? Colors.green : Colors.grey),
                  onPressed: hasMessage
                      ? () {
                          controller.sendMessage(receiverId.toString());
                        }
                      : null,
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTemplates(ChatController controller) {
    return Obx(() {
      final selectedTemplate = controller.selectedTemplate.value;
      return SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.messageTemplates.length,
          itemBuilder: (context, index) {
            final template = controller.messageTemplates[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(template['title']!),
                selected: selectedTemplate == template['title'],
                onSelected: (selected) {
                  controller.selectTemplate(index);
                  controller.messageController.text = template['message']!;
                  controller.hasMessage.value = true;
                },
                backgroundColor: Colors.grey[200],
                selectedColor: Colors.green.withOpacity(0.2),
                labelStyle: TextStyle(
                  fontSize: 12,
                  color: selectedTemplate == template['title']
                      ? Colors.green
                      : Colors.grey[700],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}