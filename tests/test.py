import requests
from requests.exceptions import ConnectionError
import argparse
import logging
import sys
import time


def main(args=sys.argv[1:], **kwargs):
    '''Test the date api '''
    mainparser = argparse.ArgumentParser(
            description='''Test an API''')
    mainparser.add_argument(
        '--host',
        dest='host',
        default='http://localhost:3838',
        help='set API Url')
    mainparser.add_argument(
        '-r', '--requests',
        dest='requests',
        default=10,
        help='set number of requests you want on the service'
    )
    parser = mainparser.parse_args(args)

    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s %(levelname)-6s %(message)s')
    logging.info(
            f'Testing API {parser.host} with {parser.requests} requests')

    success = 0
    failure = 0
    total = 0
    total_ttlb = 0

    # Exponential backoff
    attempts = 10
    timeout = 5

    while attempts is not 0:
        try:
            r = requests.get(f'{parser.host}')
            break
        except ConnectionError:
            logging.info(f'App not up sleeping for {timeout} seconds')
            time.sleep(timeout)
            attempts = attempts - 1
            timeout = timeout * 2

    try:
        for count, request in enumerate(range(int(parser.requests))):
            start = time.time()
            r = requests.get(f'{parser.host}')
            ttlb = round((time.time() - start) * 1000, 2)
            if r.status_code is 200:
                success = success + 1
                status = 'SUCCESS'
            else:
                failure = failure + 1
                status = 'FAILURE'

            application_version = r.headers.get('Application-Version')

            logging.info(
                f'{request + 1}: {status} TTLB:{ttlb}MS Version: {application_version}')
            total_ttlb = total_ttlb + ttlb
    except KeyboardInterrupt:
        total = count

    if total is 0:
        total = count + 1

    logging.info('------------------results------------------')
    logging.info(f'Success {success}/{total}')
    logging.info(f'Failure {failure}/{total}')
    logging.info(f'Average TTLB {round(total_ttlb/total, 2)}')


if __name__ == "__main__":
    main()
