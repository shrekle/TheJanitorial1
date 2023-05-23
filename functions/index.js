

const functions = require("firebase-functions");
// const firebase_tools = require('firebase-tools');
const admin = require("firebase-admin");
const serviceAccount = require(
  '/Users/adriangarcia/Desktop/nanApps/TheJanitorial1/thejanitorial-8dbbf-firebase-adminsdk-254fi-84626c1c8c.json'
  );
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

exports.notifyTaskMessage = functions.firestore
    .document("tasks/{janitorToken}")
    .onCreate((snapshot, context) => {

      console.log("------------------func began---------------");
      console.log(serviceAccount.project_id);

      const tasks = snapshot.data();
      console.log(tasks);
      const janitorToken = tasks["janitorToken"];
      
      functions.logger.log("janitor tokens:", janitorToken, "task is:", tasks);

      const payload = {
        notification: {
          title: "The Janitorial",
          body: "You got a new TO DOO-DOO!!!"
        }
      };
        // return admin.messaging.sendToDevice(janitorToken, payload)
      return admin.messaging.sendToDevice()(janitorToken, payload);
    });
