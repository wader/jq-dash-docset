#!/usr/bin/env python3

# based on build_website.py from jq

import glob
import itertools
from jinja2 import Environment, FileSystemLoader, Markup, select_autoescape, contextfunction
from markdown import markdown
import os
import os.path
import re
import shutil
import yaml

env = Environment(
  loader=FileSystemLoader('templates'),
  autoescape=select_autoescape(['html.j2']),
)

def load_yml_file(fn):
  with open(fn) as f:
    return yaml.load(f)

env.filters['search_id'] = lambda input: input.replace(r'`', '')
env.filters['section_id'] = lambda input: re.sub(r"[^a-zA-Z0-9_]", '', input)
env.filters['entry_id'] = lambda input: re.sub(r"[ `]", '', input)
env.filters['markdownify'] = lambda input: Markup(markdown(input))
env.filters['no_paragraph'] = lambda input: Markup(re.sub(r"</?p>", '', input))

env.globals['unique_id'] = contextfunction(lambda ctx: str(next(ctx['unique_ctr'])))

env.globals.update(load_yml_file('site.yml'))

output_dir = os.path.join('output')
output_path = os.path.join(output_dir, 'jq.html')

def copy_public_files(root=''):
  for f in os.scandir(os.path.join('docset', root)):
    src = os.path.join(root, f.name)
    dst = os.path.join('output', src)
    if f.is_dir():
      os.makedirs(dst, exist_ok=True)
      copy_public_files(src)
    else:
      shutil.copyfile(f.path, dst)

copy_public_files()
ctx = load_yml_file('content/manual/manual.yml')
ctx.update(unique_ctr=itertools.count(1))
os.makedirs("output", exist_ok=True)
env.get_template('docset.html.j2').stream(ctx).dump(output_path, encoding='utf-8')

