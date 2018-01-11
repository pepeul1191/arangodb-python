#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
from bottle import Bottle, request
from pprint import pprint
from datetime import datetime
from config.database import db

local_view = Bottle()

@local_view.route('/listar/<empresa_id>', method='GET')  
def listar(empresa_id):
  rpta = []
  locales = db.collection('locales').find({'empresa': empresa_id})
  for local in locales:
    try:
      rpta.append({
        '_id': local['_key'], 
        'nombre': local['nombre'], 
        'direccion': local['direccion'], 
        'latitud': local['latitud'], 
        'longitud': local['longitud'], 
        'imagen_id': local['imagen_id'], 
      })
    except KeyError as e:
      print('KeyError listar locales de empresa en ArangoDBJSON, la llave que busca ' + str(e) + ' no existe')
  return json.dumps(rpta)

@local_view.route('/guardar', method='POST')
def guardar():
  data = json.loads(request.query.data)
  nuevos = data['nuevos']
  editados = data['editados']
  eliminados = data['eliminados']
  empresa_id = data['extra']['empresa_id']
  array_nuevos = []
  rpta = None
  try:
    if len(nuevos) != 0:
      for nuevo in nuevos:
        _id = db.collection('locales').insert({
          'nombre': nuevo['nombre'], 
          'direccion': nuevo['direccion'], 
          'latitud': nuevo['latitud'], 
          'longitud': nuevo['longitud'], 
          'empresa': empresa_id, 
          'imagen_id': None, 
          'distrito_id': nuevo['distrito_id'],
          'modifiacion': None, 
          'creacion': datetime.now().__str__()
        })
        temp_id = nuevo['_id']
        temp = {'temporal': temp_id, 'nuevo_id': _id['_key']}
        array_nuevos.append(temp)
    txn = db.transaction(write = 'locales')
    if len(editados) != 0:
      for editado in editados:
        txn.collection('locales').update({
          '_key': editado['_id'], 
          'nombre': editado['nombre'], 
          'direccion': editado['direccion'], 
          'latitud': editado['latitud'], 
          'longitud': editado['longitud'], 
          'empresa': empresa_id, 
          'imagen_id': None, 
          'distrito_id': editado['distrito_id'],
          'modifiacion': datetime.now().__str__(),
        })
    if len(eliminados) != 0:
      for _key in eliminados:
        txn.collection('locales').delete({
          '_key': _key,  
        })
    rpta = {'tipo_mensaje' : 'success', 'mensaje' : ['Se ha registrado los cambios en los locales', array_nuevos]}
    txn.commit()
  except Exception as e:
    if len(array_nuevos) != 0:
      txn = db.transaction(write = 'locales')
      for temp in array_nuevos:
        _key = temp['nuevo_id']
        txn.collection('locales').delete({
          '_key': _key,  
        })
      txn.commit()
    rpta = {'tipo_mensaje' : 'error', 'mensaje' : ['Se ha producido un error en guardar los empesas', str(e)]}
  return json.dumps(rpta)