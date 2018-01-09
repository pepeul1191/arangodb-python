#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
from bottle import Bottle, request
from pprint import pprint
from config.database import db

empresa_view = Bottle()

@empresa_view.route('/listar', method='GET')
def listar():
  rpta = []
  empresas = db.collection('empresas')
  for empresa in empresas:
    rpta.append({'_id': empresa['_key'], 'razon_social': empresa['razon_social']})
  return json.dumps(rpta)

@empresa_view.route('/guardar', method='GET')
def guardar():
  txn = db.transaction(write='empresas')
  txn.collection('empresas').insert({'razon_social': 'Jake'})
  print("1+++++++++++++++++++++++++")
  pprint(vars(txn))
  txn.collection('empresas').insert({'razon_social': 'Jill'})
  print("2+++++++++++++++++++++++++")
  pprint(vars(txn._id))
  txn.commit()
  print("3+++++++++++++++++++++++++")
  pprint(vars(txn))
  print("4+++++++++++++++++++++++++")
  pprint(vars(txn._id))
  return 'rpta'