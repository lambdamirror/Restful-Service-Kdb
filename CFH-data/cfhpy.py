import requests
import urllib
import json

InsList = [ 'AUDCAD', 'AUDCHF', 'AUDJPY', 'AUDNZD', 'AUDUSD', 'CADCHF', 'CADJPY', 'CHFJPY', 'CHFNOK', 'CHFPLN', \
            'EURAUD', 'EURCAD', 'EURCHF', 'EURGBP', 'EURILS', 'EURJPY', 'EURNOK', 'EURNZD', 'EURPLN', 'EURSEK', \
            'EURTRY', 'EURUSD', 'GBPAUD', 'GBPCAD', 'GBPCHF', 'GBPJPY', 'GBPNOK', 'GBPNZD', 'GBPPLN', 'GBPUSD', \
            'NOKJPY', 'NOKSEK', 'NZDCAD', 'NZDCHF', 'NZDJPY', 'NZDUSD', 'USDCAD', 'USDCHF', 'USDDKK', 'USDILS', \
            'USDJPY', 'USDMXN', 'USDNOK', 'USDPLN', 'USDSEK', 'USDTRY', 'USDZAR', 'XAGUSD', 'XAUUSD', 'USDSGD', \
            'EURCZK', 'USDCZK', 'GBPSEK', 'GBPTRY', 'GBPZAR', 'USDHKD', 'USDHUF', 'USDTHB', 'XAUEUR', 'XAUTRY', \
            'EURZAR', 'EURMXN', 'AUDSEK', 'AUDNOK', 'EURHUF', 'XAUGBP', 'GBPDKK', 'AUDHUF', 'CHFHUF', 'GBPHUF', \
            'NZDHUF', 'AUDSGD', 'CHFDKK', 'CHFSEK', 'EURDKK', 'EURHKD', 'EURSGD', 'GBPSGD', 'HKDJPY', 'NZDSGD', \
            'SEKJPY', 'SGDJPY', 'TRYJPY', 'ZARJPY', 'XPDUSD', 'XPTUSD', 'USDCNH', 'XAUCNH', 'GBPMXN', 'XAUAUD', \
            'XAGEUR', 'XNGUSD', 'CHFSGD', 'XAGSGD', 'XAUSGD', 'XALUSD', 'XZNUSD', 'XCUUSD', 'XPBUSD', 'XNIUSD']

#%%%%
class MarketData:
    """
    Class for retrieving data from CFH database
    """
    def __init__(self, symbol: str = 'EURUSD'):
        '''
        To change symbol  -> symbol = ''
        '''
        self.symbol = symbol.upper()
        self.http_way = 'http://localhost:2101/'

    '''
    Implied requets functions
    '''
    def _get_request(self, req):
        r = requests.get( self.request_url(req=req) )
        try:
            return r.json()
        except:
            return r

    def _post_request(self, req, body):
        r = requests.post( self.request_url(req=req),
                           data=json.dumps(body) )
        try:
            return r.json()
        except:
            return r

    def _delete_request(self, req):
        r = requests.delete( self.request_url(req=req) )
        try:
            return r.json()
        except:
            return r

    def _put_request(self, req, body):
        r = requests.put( self.request_url(req=req),
                          data=json.dumps(body) )
        try:
            return r.json()
        except:
            return r

    def request_url(self, req, http_way=None):
        return urllib.parse.urljoin(self.http_way or http_way, req)

    '''
    REST api methods for Market data
    '''
    def candle_data(    self,
                        interval : str,
                        pxType : str,
                        startTime : str,
                        endTime : str   ):
        '''
        To change interval                  ->  interval = 5

        To change pxType                    ->  pxType = "bid"/"ask"

        To change start time and end time   ->  startTime = "2020.01.01D00:00:00"
                                            ->  endTime = "2020.01.01D00:00:00"
        '''
        params = {  'symbol' : self.symbol,
                    'interval' : str(interval),
                    'pxType' : pxType,
                    'startTime' : startTime,
                    'endTime' : endTime }
        query = urllib.parse.urlencode(dict([(k, v) for (k, v) in iter(params.items()) if v]))
        req = f'candles?{query}'
        return self._get_request(req)

    def quote_data( self,
                    startTime : str,
                    endTime : str   ):
        '''
        To change start time and end time   ->  startTime = "2020.01.01D00:00:00"
                                            ->  endTime = "2020.01.01D00:00:00"
        '''
        params = {  'symbol' : self.symbol,
                    'startTime' : startTime,
                    'endTime' : endTime }
        query = urllib.parse.urlencode(dict([(k, v) for (k, v) in iter(params.items()) if v]))
        req = f'quotes?{query}'
        return self._get_request(req)

#%%%%