/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

exports.checkUpcomingEvents = functions.pubsub.schedule('every 10 minutes').onRun(async (context) => {
    const now = new Date();
    const twoHoursLater = new Date(now.getTime() + 2 * 60 * 60 * 1000);

    const snapshot = await db.collection("events")
        .where("eventTime", ">=", admin.firestore.Timestamp.fromDate(now))
        .where("eventTime", "<=", admin.firestore.Timestamp.fromDate(twoHoursLater))
        .get();

    snapshot.forEach(async (doc) => {
        const event = doc.data();
        logger.info(`Event found: ${event.title} at ${event.eventTime.toDate()}`);
        const payload = {
            notification: {
                title: "Event Reminder",
                body: `Your event "${event.title}" starts in 2 hours.`,
            }
        };

        for (const token of event.guestTokens) {
            await admin.messaging().sendToDevice(token, payload);
        }
    });

    return null;
});
