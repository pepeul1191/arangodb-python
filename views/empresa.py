#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
from bottle import Bottle, request
from pprint import pprint
from datetime import datetime
from config.database import db

empresa_view = Bottle()

@empresa_view.route('/listar', method='GET')
def listar():
  rpta = []
  empresas = db.collection('empresas')
  for empresa in empresas:
    try:
      rpta.append({'_id': empresa['_key'], 'razon_social': empresa['razon_social'], 'ruc': empresa['ruc'], 'direccion': empresa['direccion']})
    except KeyError as e:
      print('KeyError en ArangoDBJSON, la llave que busca ' + str(e) + ' no existe')
  return json.dumps(rpta)

@empresa_view.route('/guardar', method='POST')
def guardar():
  data = json.loads(request.query.data)
  nuevos = data['nuevos']
  editados = data['editados']
  eliminados = data['eliminados']
  array_nuevos = []
  rpta = None
  try:
    if len(nuevos) != 0:
      for nuevo in nuevos:
        temp_id = nuevo['_id']
        razon_social = nuevo['razon_social']
        ruc = nuevo['ruc']
        nombre_comercial = nuevo['nombre_comercial']
        domicilio_fiscal = nuevo['domicilio_fiscal']
        distrito_id = nuevo['distrito_id']
        creacion = datetime.now().__str__()
        modificacion = None
        _id = db.collection('empresas').insert({
          'razon_social': razon_social, 
          'ruc': ruc, 
          'nombre_comercial': nombre_comercial, 
          'domicilio_fiscal': domicilio_fiscal, 
          'distrito_id': distrito_id, 
          'modifiacion': None, 
          'creacion': creacion
        })
        temp = {'temporal': temp_id, 'nuevo_id': _id['_key']}
        array_nuevos.append(temp)
    txn = db.transaction(write = 'empresas')
    if len(editados) != 0:
      for editado in editados:
        _key = editado['_id']
        razon_social = editado['razon_social']
        ruc = editado['ruc']
        nombre_comercial = editado['nombre_comercial']
        domicilio_fiscal = editado['domicilio_fiscal']
        distrito_id = editado['distrito_id']
        modificacion = datetime.now().__str__()
        txn.collection('empresas').update({
          '_key': _key, 
          'razon_social': razon_social, 
          'ruc': ruc, 
          'nombre_comercial': nombre_comercial, 
          'domicilio_fiscal': domicilio_fiscal, 
          'distrito_id': distrito_id, 
          'modifiacion': modificacion, 
        })
    if len(eliminados) != 0:
      for _key in eliminados:
        txn.collection('empresas').delete({
          '_key': _key,  
        })
    rpta = {'tipo_mensaje' : 'success', 'mensaje' : ['Se ha registrado los cambios en las empresas', array_nuevos]}
    txn.commit()
  except Exception as e:
    #session.rollback()
    rpta = {'tipo_mensaje' : 'error', 'mensaje' : ['Se ha producido un error en guardar las empesas', str(e)]}
  return json.dumps(rpta)

@empresa_view.route('/guardarsh', method='POST')
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