"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getPlacePercentageReviews = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);
exports.getPlacePercentageReviews = functions.https.onRequest((request, response) => {
    admin.firestore().collection("places").doc('7NqVMTiCd3mHKvm3QCQE').get()
        .then(snapshot => {
        const data = snapshot.data;
        console.log(data);
        response.send(data);
    })
        .catch(error => {
        console.log(error);
        response.status(500).send(error);
    });
});
//# sourceMappingURL=index.js.map