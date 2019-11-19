import os
import sys
import slack
import argparse

if __name__== "__main__":

    arg_parser = argparse.ArgumentParser(formatter_class=argparse.MetavarTypeHelpFormatter)
    arg_parser.add_argument('--token', type=str, required=False, default=os.environ.get("SLACK_API_TOKEN", None), help='slack tocken')
    arg_parser.add_argument('-d', type=str, required=False, help='channel')

    args, unknown_args = arg_parser.parse_known_args()
    if args.token is None:
        print('SLACK_API_TOKEN is required')
        sys.exit(-1) 

    msg = ' '.join(unknown_args)

    client = slack.WebClient(token=args.token)
    
    client.chat_postMessage(
      channel=args.d,
      text=msg
    )

    print('{} -> {}'.format(msg, args.d))
