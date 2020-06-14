import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase)


export const getPlacePercentageReviews = functions.https.onRequest((request, response) => {



    function distance(lat1:number, lon1:number, lat2:number, lon2:number, unit:string) {
        var radlat1 = Math.PI * lat1/180
        var radlat2 = Math.PI * lat2/180
        var theta = lon1-lon2
        var radtheta = Math.PI * theta/180
        var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
        if (dist > 1) {
            dist = 1;
        }
        dist = Math.acos(dist)
        dist = dist * 180/Math.PI
        dist = dist * 60 * 1.1515
        if (unit=="K") { dist = dist * 1.609344 }
        if (unit=="N") { dist = dist * 0.8684 }
        return dist
    }


    
    let lat = request.query.lat
    let lng = request.query.lng
    let uf = request.query.uf

    let lat_num = Number(lat)
    let lng_num = Number(lng)
    let uf_str = String(uf)

    var data = Array()

    admin.firestore().collection("placesOpt").doc(uf_str).collection(uf_str).get()
        .then(snapshot => {
                data.push(
                    snapshot.docs.map(doc => doc.data())
                );
        

                async function getFirstClosest() {
                    
                    let closest = []

                    for (const place of data.slice(5,)) {
                        response.send(place)
                        closest.push([place, distance(lat_num, lng_num, place.coordinates._latitude, place.coordinates._longitude, "k")])
                    }
                    return closest
                }

                const something = async () =>{

                    let closest = await getFirstClosest
                    return closest
                }
                console.log('ooo')
                console.log(something)
                //response.send(data)

        /*
        for (const place of data.slice(5,)) {
            console.log(place);
        }
        */

        })
        .catch(error => {
                console.log(error)
                response.status(500).send(error)
        })
})
    

    
/*
    async () => {

        const all_data = await promise()
        let closest = distance(lat_num, lng_num, all_data[0].coordinates._latitude, all_data[0].coordinates._longitude, "K")
        response.send(closest)
        response.send(all_data)
    }
    

   let placesRef = admin.firestore().collection("places")
   placesRef.where('uf', '==', ufs_ls[0]).get()
   .then(snapshot => {
     if (snapshot.empty) {
       console.log('Não foram encontrados pontos para este estado.');
       response.send(ufs_ls[0])
       return;
     }
 
    console.log(snapshot.docs)
    response.send(snapshot.docs);
     /*
     snapshot.forEach(doc => {
       console.log(doc.id, '=>', doc.data());
       response.send(doc.data());
     });
   })
   .catch(err => {
     console.log('Error getting documents', err);
   });
   */

