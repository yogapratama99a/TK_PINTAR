import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  final box = GetStorage();

  var hasMessage = false.obs;
  var selectedTemplate = ''.obs;
  var messages = <Map<String, dynamic>>[].obs;
  var currentUserId = ''.obs;
  var currentUserRole = ''.obs; // 'teacher' or 'parent'

  // Message templates
  final messageTemplates = [
    {'title': 'Assalamu\'alaikum', 'message': 'Assalamu\'alaikum, Pak/Bu.'},
    {'title': 'Terima kasih', 'message': 'Terima kasih atas bantuannya.'},
    {'title': 'Saya izin', 'message': 'Saya izin tidak hadir hari ini.'},
  ];

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {
    currentUserId.value = (box.read('user_id') ?? '').toString().trim();
    currentUserRole.value = (box.read('user_role') ?? '').toString().trim();

    if (currentUserId.value.isEmpty) {
      print('User ID kosong, redirect ke login');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed('/login');
      });
      return;
    }

    print('User loaded: ${currentUserId.value} (${currentUserRole.value})');
  }

  // Simpan otherUserId sementara
  String _otherUserId = '';

  void prepareChat(String otherUserId) {
    _otherUserId = otherUserId;
    print('Current userId = ${currentUserId.value}');
    print('Other userId = $_otherUserId');
    print('Chat ID = ${generateChatId(currentUserId.value, _otherUserId)}');

    if (currentUserId.isNotEmpty) {
      fetchMessages(otherUserId);
    }
  }

  // Generate consistent chat ID regardless of sender/recipient order
  String generateChatId(String userId1, String userId2) {
    final ids = [userId1, userId2]..sort();
    return ids.join('_');
  }

  void selectTemplate(int index) {
    final template = messageTemplates[index];
    selectedTemplate.value = template['title']!;
    messageController.text = template['message']!;
    hasMessage.value = true;
  }

  void clearMessage() {
    messageController.clear();
    hasMessage.value = false;
    selectedTemplate.value = '';
  }

  StreamSubscription? _chatSubscription;

  void fetchMessages(String otherUserId) {
    final chatId = generateChatId(currentUserId.value, otherUserId);

    // Hentikan listener lama (kalau ada)
    _chatSubscription?.cancel();

    _chatSubscription = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('time', descending: false)
        .snapshots()
        .listen((snapshot) {
      final newMessages = snapshot.docs.map((doc) {
        final data = doc.data();
        Timestamp? timestamp = data['time'];
        Timestamp? readAt = data['readAt']; // tambahkan ini

        return {
          'id': doc.id,
          'message': data['message'] ?? '',
          'time': timestamp != null ? timestamp.toDate() : DateTime.now(),
          'readAt': readAt?.toDate(),
          'isMe': data['senderId'].toString() == currentUserId.value,
          'senderRole': data['senderRole'] ?? '',
        };
      }).toList();

      final isNewMessage = newMessages.length != messages.length;
      messages.value = newMessages;

      if (isNewMessage) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      }
    });
  }

  Future<void> sendMessage(String otherUserId) async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final chatId = generateChatId(currentUserId.value, otherUserId);

    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'message': text,
        'time': FieldValue.serverTimestamp(),
        'senderId': currentUserId.value,
        'senderRole': currentUserRole.value,
        'readAt': null, // tambahkan
        'localTime': DateTime.now(),
      });

      clearMessage(); // clear input + template setelah kirim
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  

  @override
  void onClose() {
    _chatSubscription?.cancel(); // jangan lupa cancel listener
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
