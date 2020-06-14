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
    let qtd = request.query.qtd

    let lat_num = Number(lat)
    let lng_num = Number(lng)
    let uf_str = String(uf)
    let qtd_num = Number(qtd)


    admin.firestore().collection("placesOpt").doc(uf_str).collection(uf_str).get()
        .then(snapshot => {
                
                let data = snapshot.docs.map(doc => doc.data())
                
                if (qtd_num > data.length) {
                    qtd_num = data.length - 1
                }

            try{
                let closest = []
                for (const place of data.slice(0,qtd_num)) {
                    closest.push({
                    "dist": distance(lat_num, lng_num, 
                        place.coordinates._latitude,
                        place.coordinates._longitude, "K"),
                    "place": place
                    })
                }
                
                closest.sort((a, b) => a.dist < b.dist ? -1 : a.dist > b.dist ? 1 : 0)

                for (const place of data.slice(qtd_num,)) {
                    let curr_dist =  distance(lat_num, lng_num, place.coordinates._latitude,                            place.coordinates._longitude, "K")
                  
                    let control=true
                    closest = closest.map(item => {
                      if (item.dist > curr_dist && control){
                        control = false
                        return {"dist": curr_dist, "place": place}
                      } else {
                        return item
                      }
                    })
                  }

                let response_obj = []
                for (const place of closest) {
                    response_obj.push(place.place)
                }

                response.send(response_obj)


            } catch(e) {
                console.log('ooo')
                response.send('error')
            }

        })
        .catch(error => {
                console.log(error)
                response.status(500).send(error)
        })
})
    
