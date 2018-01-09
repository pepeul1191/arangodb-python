#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
from bottle import Bottle, request
from models.empresa import Empresa

empresa_view = Bottle()

@empresa_view.route('/listar', method='GET')
def listar():
  empresas = Empresa().listar()
  return json.dumps(empresas)