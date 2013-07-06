import sys
sys.stdout = sys.stderr

import os
os.environ['TRAC_ENV'] = '/var/trac/sites/MyProject'
os.environ['PYTHON_EGG_CACHE'] = '/var/trac/eggs'

import trac.web.main

application = trac.web.main.dispatch_request
