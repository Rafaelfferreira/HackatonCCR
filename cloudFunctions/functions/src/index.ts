import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase)


export const getPlacePercentageReviews = functions.https.onRequest((request, response) => {
    
    admin.firestore().collection("places").doc('7NqVMTiCd3mHKvm3QCQE').get()
    .then(snapshot => {
        const data = snapshot.data
        console.log(data)
        response.send(data)
    })
    .catch(error => {
        console.log(error)
        response.status(500).send(error)
    })

});
