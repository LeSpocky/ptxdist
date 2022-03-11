#!/usr/bin/env python3

from os import path
from sys import argv
from jsonschema import validate
import yaml

if len(argv) != 2:
  print(f"usage: {argv[0]} <report-file>.yaml")
  exit(1)

schema_file = path.join(path.dirname(argv[0]), 'bsp-report-schema.yaml')

schema = yaml.load(open(schema_file).read(), Loader=yaml.SafeLoader)
data = yaml.load(open(argv[1]).read(), Loader=yaml.SafeLoader)

validate(data, schema)

