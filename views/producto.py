#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
from bottle import Bottle, request
from pprint import pprint
from datetime import datetime
from config.database import db

producto_view = Bottle()

@producto_view.route('/listar', method='GET')  
def listar():
  rpta = []
  locales = db.collection('productos')
  for local in locales:
    try:
      rpta.append({
        '_id': local['_key'], 
        'nombre': local['nombre'], 
        'precio_referencial': local['precio_referencial'], 
        'imagen_id': local['imagen_id'], 
      })
    except KeyError as e:
      print('KeyError listar productos en ArangoDBJSON, la llave que busca ' + str(e) + ' no existe')
  return json.dumps(rpta)

@producto_view.route('/guardar', method='POST')
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
        _id = db.collection('productos').insert({
          'nombre': nuevo['nombre'], 
          'precio_referencial': nuevo['precio_referencial'], 
          'imagen_id': nuevo['imagen_id'], 
          'modifiacion': None, 
          'creacion': datetime.now().__str__()
        })
        temp_id = nuevo['_id']
        temp = {'temporal': temp_id, 'nuevo_id': _id['_key']}
        array_nuevos.append(temp)
    txn = db.transaction(write = 'productos')
    if len(editados) != 0:
      for editado in editados:
        txn.collection('productos').update({
          '_key': editado['_id'], 
          'nombre': editado['nombre'], 
          'precio_referencial': editado['precio_referencial'], 
          'imagen_id': editado['imagen_id'], 
          'modifiacion': datetime.now().__str__(), 
        })
    if len(eliminados) != 0:
      for _key in eliminados:
        txn.collection('productos').delete({
          '_key': _key,  
        })
    rpta = {'tipo_mensaje' : 'success', 'mensaje' : ['Se ha registrado los cambios en los productos', array_nuevos]}
    txn.commit()
  except Exception as e:
    if len(array_nuevos) != 0:
      txn = db.transaction(write = 'productos')
      for temp in array_nuevos:
        _key = temp['nuevo_id']
        txn.collection('productos').delete({
          '_key': _key,  
        })
      txn.commit()
    rpta = {'tipo_mensaje' : 'error', 'mensaje' : ['Se ha producido un error en guardar los productos', str(e)]}
  return json.dumps(rpta)