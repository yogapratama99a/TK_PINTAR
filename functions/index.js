const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

// Fungsi otomatis update readAt kalau pesan dibuka (optional, kalau mau support "message read")
exports.setReadAtOnMessageFetch = functions.firestore
    .document('chats/{chatId}/messages/{messageId}')
    .onUpdate(async (change, context) => {
        const beforeData = change.before.data();
        const afterData = change.after.data();

        // Kalau pesan sudah ada readAt sebelumnya, tidak perlu update
        if (afterData.readAt) {
            return null;
        }

        // Kalau isi pesan tidak berubah, abaikan
        if (beforeData.message === afterData.message) {
            return null;
        }

        const messageRef = change.after.ref;
        return messageRef.update({
            readAt: admin.firestore.FieldValue.serverTimestamp()
        });
    });

// Fungsi kirim notifikasi saat ada pesan baru (optional)
exports.sendNotificationOnNewMessage = functions.firestore
    .document('chats/{chatId}/messages/{messageId}')
    .onCreate(async (snap, context) => {
        const newMessage = snap.data();
        const { chatId } = context.params;

        const messageText = newMessage.message;
        const senderRole = newMessage.senderRole;
        const senderId = newMessage.senderId;

        // Misal kita ambil userId penerima (dari chatId)
        const ids = chatId.split('_');
        const recipientId = ids.find(id => id !== senderId);

        // Contoh: ambil FCM token user penerima dari users/{userId}/fcmToken (kalau kamu simpan di situ)
        const userDoc = await db.collection('users').doc(recipientId).get();
        const recipientData = userDoc.data();
        const fcmToken = recipientData?.fcmToken;

        if (!fcmToken) {
            console.log(`No FCM token for user ${recipientId}`);
            return null;
        }

        const payload = {
            notification: {
                title: senderRole === 'teacher' ? 'Pesan dari Guru' : 'Pesan dari Orang Tua',
                body: messageText,
            }
        };

        try {
            await admin.messaging().sendToDevice(fcmToken, payload);
            console.log(`Notification sent to ${recipientId}`);
        } catch (error) {
            console.error('Error sending notification:', error);
        }

        return null;
    });
