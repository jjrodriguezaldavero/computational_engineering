import datetime 
import requests
import sys
import json
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
%matplotlib inline
import time

#user parameters

username = 'YOUR_API_USERNAME'
token = 'YOUR_TOKEN'
#static parameters
prefix_data_query = 'https://ooinet.oceanobservatories.org/api/m2m/12576/sensor/inv/'
begin = '2018-12-10T00:00:00.0Z'
end =   '2018-12-12T00:00:00.0Z'
limit = '1000'

#CTD 194m
ref_designator = 'CE04OSPS/PC01B/4A-CTDPFA109' #subsite/node/sensor
method = 'streamed'
stream = 'ctdpf_optode_sample'

#CTD 2903m
#ref_designator = 'RS01SLBS/LJ01A/12-CTDPFB101' #subsite/node/sensor
#method = 'streamed'
#stream = 'ctdpf_optode_sample'

#CTD 1542m
#ref_designator = 'RS03ASHS/MJ03B/10-CTDPFB304' #subsite/node/sensor
#method = 'streamed'
#stream = 'ctdpf_optode_sample'

#CTD 581m
#ref_designator = 'CE04OSBP/LJ01C/06-CTDBPO108' #subsite/node/sensor
#method = 'streamed'
#stream = 'ctdbp_no_sample'

#BOTPT
#ref_designator = 'RS03ECAL/MJ03E/06-BOTPTA302' #subsite/node/sensor
#method = 'streamed'
#stream = 'botpt_nano_sample'
 
req = requests.get(prefix_data_query+ref_designator+'/'+method+'/'+stream+'?beginDT='+begin+'&endDT='+end+'&limit='+limit+'&user='+username, auth=(username, token))
data = req.json()

df = pd.DataFrame(data)

# Plot data
#ntp_diff = (datetime.datetime(1970, 1, 1) - datetime.datetime(1900, 1, 1)).total_seconds()
#df['time'] = pd.to_datetime(df.time - ntp_diff, unit='s')
#df = df.set_index(df.time)
#plt.plot(df['time'], df['seawater_temperature'])
#locs, labels = plt.xticks()
#plt.setp(labels, rotation=45)
#plt.show()

#plt.plot(df['time'], df['seawater_pressure'])
#locs, labels = plt.xticks()
#plt.setp(labels, rotation=45)
#plt.show()


## Save data to file
df['seawater_temperature'].to_csv('194m_temp.txt', index=None,)
df['seawater_pressure'].to_csv('194m_pres.txt', index=None,)


