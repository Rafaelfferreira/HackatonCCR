import urllib
import urllib.request
import json
import re
import pandas as pd
from tqdm import tqdm


def get_loc_by_name(address):
    
    address = urllib.parse.quote(address)
    
    MyUrl = ('https://maps.googleapis.com/maps/api/place/findplacefromtext/json'
           '?input=%s'
            '&inputtype=textquery'
            '&fields=geometry,place_id'
             '&key=AIzaSyBW83BvH2RsLsrxlA7bXLsO4Q_YkynHnGk'
            ) % (address)
    
    response = urllib.request.urlopen(MyUrl)
    jsonRaw = response.read()
    jsonData = json.loads(jsonRaw)
    
    if len(jsonData['candidates']) > 0:
        lat = jsonData['candidates'][0]['geometry']['location']['lng']
        lng = jsonData['candidates'][0]['geometry']['location']['lat']
        
        place_id = jsonData['candidates'][0]['place_id']
        
        
        urlID = ('https://maps.googleapis.com/maps/api/place/details/json?place_id=%s'
                 '&fields=name,formatted_phone_number,formatted_address,adr_address'
                 '&key=AIzaSyBW83BvH2RsLsrxlA7bXLsO4Q_YkynHnGk') % (place_id)
        
        response = urllib.request.urlopen(urlID)
        jsonRaw = response.read()
        jsonData = json.loads(jsonRaw)
        
        name=""
        addr=""
        phone=""
        city=""
        
        r = jsonData['result']
        try:
            name = r['name']
        except:
            pass
        
        try:
            addr = r['formatted_address']
        except:
            pass
        
        try:
            phone = r['formatted_phone_number']
        except:
            pass
        
        
        try:
            city = re.search('<span class=\"locality\">'+'(.+?)'+'</span>', r['adr_address']).group(1) 
        except:
            pass
            
        return place_id, lat, lng, name, addr, phone, city
    
    else:
        return False




df = pd.read_csv('/home/colombelli/Desktop/dados/processed.csv')
db_df = {
    'gplace_id': [],
    'lat': [],
    'lng': [],
    'name': [],
    'addr': [],
    'phone': [],
    'city': [],
    'uf': [],
    'prices': []
}


with tqdm(total=len(list(df.iterrows()))) as pbar:
    for i, row in df.iterrows():
        pbar.update(1)
        

        name = row['Revenda']
        city = row['Município']
        state = row['Estado - Sigla']
        price = row['Valor de Venda']

        address = name + " " + city + " " + state
        
        try:
            gplace_id, lat, lng, name, addr, phone, city = get_loc_by_name(address)
        except:
            continue
        
        db_df['gplace_id'].append(gplace_id)
        db_df['lat'].append(lat)
        db_df['lng'].append(lng)
        db_df['name'].append(name)
        db_df['addr'].append(addr)
        db_df['phone'].append(phone)
        db_df['city'].append(city)

        db_df['uf'].append(state)
        db_df['prices'].append(price)


final_db = pd.DataFrame.from_dict(db_df)
final_db.to_csv('/home/colombelli/Desktop/dados/db_df.csv', index=False)