import warnings
warnings.simplefilter("ignore")

import time, sys
import numpy as np
import pandas as pd
from datetime import datetime
from cfhpy import MarketData, InsList

start_time = time.time()

def main(args):
    '''
    Main function to call class MarketData
    '''
    filepath = 'data/'
    slist = [ 'AUDCAD']
    for symbol in slist:
        data = MarketData(symbol=symbol)
        interval = 10 #minutes
        pxType = 'bid'
        t_start = '2020.08.25D00:00:00'
        t_end = '2020.08.25D12:00:00'

        klns = data.candle_data(interval=interval, pxType=pxType, startTime=t_start, endTime=t_end)
        kln_df = pd.DataFrame(klns)
        klnfile = filepath + "%s-%s%d.csv" % (symbol, pxType, interval)
        kln_df.to_csv(klnfile)

        qts = data.quote_data(startTime=t_start, endTime=t_end)
        qts_df = pd.DataFrame(qts)
        qtsfile = filepath + "%s-quote.csv" % (symbol)
        qts_df.to_csv(qtsfile)

    print('\n\nElapsed time = ' + str(time.time()-start_time))
    print("\n#################### \n")

if __name__ == '__main__':
    main(sys.argv[1:])
